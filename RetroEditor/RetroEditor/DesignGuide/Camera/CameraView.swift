//
//  CameraView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//
// The base code is https://github.com/brettfazio/CameraView
// Modified by haeun lee

import SwiftUI
import UIKit
import AVFoundation
import Combine

public class CameraObject: ObservableObject {
    @Published var didTapCapture: Bool = false
}

public protocol CameraViewDelegate {
    func cameraAccessGranted()
    func cameraAccessDenied()
    func noCameraDetected()
    func cameraSessionStarted()
    func processedImage(image: UIImage)
}

public struct CameraView: View {
    private var delegate: CameraViewDelegate?
    private var cameraType: AVCaptureDevice.DeviceType
    private var cameraPosition: AVCaptureDevice.Position
    @ObservedObject var events: CameraObject

    public init(delegate: CameraViewDelegate? = nil, cameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera, cameraPosition: AVCaptureDevice.Position = .back, events: CameraObject) {
        self.delegate = delegate
        self.cameraType = cameraType
        self.cameraPosition = cameraPosition
        self.events = events

    }

    public var body: some View {
        PreviewHolder(delegate: delegate, cameraType: cameraType, cameraPosition: cameraPosition, events: events)
    }
}

private class PreviewView: UIView {

    private var delegate: CameraViewDelegate?

    private var captureSession: AVCaptureSession?
    var photoOutput: AVCapturePhotoOutput?

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

    init(
        delegate: CameraViewDelegate? = nil,
        cameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
        cameraPosition: AVCaptureDevice.Position = .back
    ) {
        super.init(frame: .zero)

        self.delegate = delegate

        var accessAllowed = false

        let blocker = DispatchGroup()
        blocker.enter()

        AVCaptureDevice.requestAccess(for: .video) { (flag) in
            accessAllowed = true
            delegate?.cameraAccessGranted()
            blocker.leave()
        }

        blocker.wait()

        if !accessAllowed {
            delegate?.cameraAccessDenied()
            return
        }

        let session = AVCaptureSession()
        session.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(cameraType,
                                                  for: .video, position: cameraPosition)

        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
            delegate?.noCameraDetected()
            return
        }
        session.addInput(videoDeviceInput)
        session.commitConfiguration()

        photoOutput = AVCapturePhotoOutput()
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        session.addOutput(photoOutput!)

        self.captureSession = session
        delegate?.cameraSessionStarted()
    }

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if nil != self.superview {
            self.videoPreviewLayer.session = self.captureSession
            self.videoPreviewLayer.videoGravity = .resizeAspectFill
            self.captureSession?.startRunning()
        } else {
            self.captureSession?.stopRunning()
        }
    }

    func didTapRecord() {
        print("didTapRecord")
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}

extension PreviewView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        if let imageData = photo.fileDataRepresentation() {

            let cropView = cropCameraImage(UIImage(data: imageData)!, previewLayer: self.videoPreviewLayer)
            UIImageWriteToSavedPhotosAlbum(cropView!, self, nil, nil)

            delegate?.processedImage(image: cropView!)

        }
    }

    func cropCameraImage(_ original: UIImage, previewLayer: AVCaptureVideoPreviewLayer) -> UIImage? {

        var image = UIImage()

        let previewImageLayerBounds = previewLayer.bounds

        let originalWidth = original.size.width
        let originalHeight = original.size.height

        let A = previewImageLayerBounds.origin
        let B = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.origin.y)
        let D = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.size.height)

        let a = previewLayer.captureDevicePointConverted(fromLayerPoint: A)
        let b = previewLayer.captureDevicePointConverted(fromLayerPoint: B)
        let d = previewLayer.captureDevicePointConverted(fromLayerPoint: D)

        let posX = floor(b.x * originalHeight)
        let posY = floor(b.y * originalWidth)

        let width: CGFloat = d.x * originalHeight - b.x * originalHeight
        let height: CGFloat = a.y * originalWidth - b.y * originalWidth

        let cropRect = CGRect(x: posX, y: posY, width: width, height: height)

        if let imageRef = original.cgImage?.cropping(to: cropRect) {
            image = UIImage(cgImage: imageRef, scale: original.scale, orientation: original.imageOrientation)
        }

        return image
    }
}

private struct PreviewHolder: UIViewRepresentable {
    private var delegate: CameraViewDelegate?
    private var cameraType: AVCaptureDevice.DeviceType
    private var cameraPosition: AVCaptureDevice.Position

    @ObservedObject var events: CameraObject

    typealias UIViewType = PreviewView

    init(
        delegate: CameraViewDelegate? = nil,
        cameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
        cameraPosition: AVCaptureDevice.Position = .back,
        image: UIImage? = nil,
        events: CameraObject
    ) {
        self.delegate = delegate
        self.cameraType = cameraType
        self.cameraPosition = cameraPosition
        self.events = events
    }

    func makeUIView(context: UIViewRepresentableContext<PreviewHolder>) -> PreviewView {
        PreviewView(delegate: delegate, cameraType: cameraType, cameraPosition: cameraPosition)
    }

    func updateUIView(_ uiView: PreviewView, context: UIViewRepresentableContext<PreviewHolder>) {
        if events.didTapCapture {
            print("updateUIView")
            uiView.didTapRecord()
        }
    }
}
