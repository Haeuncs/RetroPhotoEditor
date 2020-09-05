//
//  CustomCameraView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//


import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    @ObservedObject var events = CameraObject()
    @State var image: UIImage?
    @State var didTapCapture: Bool = false
    @State var presentSticker: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationView()
                HStack(spacing:0) {
                    WindowsStyleButton(imageNamed: "icnAlbum", text: "Open Album")
                    WindowsStyleButton(imageNamed: "icnCrop", text: "Ratio")
                }
                VStack() {
                    Spacer()
                    if self.image != nil {
                        Image(uiImage: image ?? UIImage())
                            .resizable()
                            .frame(width: geometry.size.width - 4, height: geometry.size.width - 4, alignment: .center)
                    } else {
                        CameraView(
                            delegate: self,
                            didTapCapture: self.$didTapCapture, events: events
                        )
                            .frame(width: geometry.size.width - 4, height: geometry.size.width - 4, alignment: .center)
                    }
                    Spacer()
                }
                HStack(spacing:0) {
                    if self.image == nil {
                        WindowsStyleButton(imageNamed: "icnCamera", text: "Capture") {
                            events.didTapCapture = true
                            print("didTap")
                        }
                    } else {
                        WindowsStyleButton(imageNamed: "icnRetry", text: "Retry") {
                            self.image = nil
                        }
                        WindowsStyleButton(imageNamed: "icnPoison", text: "Done") {
                            presentSticker = !presentSticker
                        }
                        .fullScreenCover(isPresented: $presentSticker) {
                            PhotoEditView(image: self.image!)
                        }
                        .frame(maxWidth: 100, maxHeight: 62, alignment: .center)
                    }
                }
            }
            .background(Color.Retro.gray4)
            .windowsBorder()
        }
        
    }
}

extension CustomCameraView: CameraViewDelegate {
    func processedImage(image: UIImage) {
        self.image = image
        events.didTapCapture = false
    }

    func cameraAccessGranted() {

    }

    func cameraAccessDenied() {

    }

    func noCameraDetected() {

    }

    func cameraSessionStarted() {

    }
}

struct CaptureButtonView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Image(systemName: "video").font(.largeTitle)
            .padding(30)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false))
        )
            .onAppear
            {
                self.animationAmount = 2
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCameraView(image: nil)
    }
}
