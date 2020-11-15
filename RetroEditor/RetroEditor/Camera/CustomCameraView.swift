//
//  CustomCameraView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//


import SwiftUI
import AVFoundation

class CustomCameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
}

struct CustomCameraView: View {
    class CustomCameraSheetNavigator: ObservableObject {
        enum Destination {
            case Sticker(viewModel: CustomCameraViewModel)
            case Album(completion: ((UIImage) -> Void))
        }

        @Published var showSheet = false
        var sheetDesitination: Destination? = .none {
            didSet {
                showSheet = true
            }
        }

        func sheetView() -> AnyView? {
            switch sheetDesitination {
            case .Album(let completion):
                return AnyView(ImagePicker(completion: completion))
            case .Sticker(let viewModel):
                let photoEditView = PhotoEditView(
                        image: viewModel.capturedImage!,
                        customCameraViewModel: viewModel
                )
                return AnyView(photoEditView)
            case .none:
                return nil
            }
        }
    }
    
    @ObservedObject var events = CameraObject()
    @ObservedObject var viewModel = CustomCameraViewModel()
    @ObservedObject var sheetNavigator = CustomCameraSheetNavigator()

    @State var didTapCapture: Bool = false
    @State var didSelectedImage: Image?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationView()
                HStack(spacing:0) {
                    WindowsStyleButton(image: UIImage.icnAlbum, text: "Open Album") {
                        let completion = { image in
                            viewModel.capturedImage = image
                        }
                        sheetNavigator.sheetDesitination = .Album(completion: completion)
                    }
                    WindowsStyleButton(image: UIImage.icnCrop, text: "Ratio")
                }
                VStack() {
                    Spacer()
                    if let image = viewModel.capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: geometry.size.width - 4, height: geometry.size.width - 4, alignment: .center)
                    } else {
                        CameraView(
                            delegate: self,
                            events: events
                        )
                        .frame(width: geometry.size.width - 4, height: geometry.size.width - 4, alignment: .center)
                    }
                    Spacer()
                }
                HStack(spacing:0) {
                    if viewModel.capturedImage == nil {
                        WindowsStyleButton(image: UIImage.icnCamera, text: "Capture") {
                            events.didTapCapture = true
                        }
                    } else {
                        WindowsStyleButton(image: UIImage.icnRetry, text: "Retry") {
                            viewModel.capturedImage = nil
                        }
                        WindowsStyleButton(image: UIImage.icnPoison, text: "Done") {
                            sheetNavigator.sheetDesitination = .Sticker(viewModel: self.viewModel)
                        }
                        .frame(maxWidth: 100, maxHeight: 62, alignment: .center)
                    }
                }
            }
            .fullScreenCover(isPresented: $sheetNavigator.showSheet, content: {
                sheetNavigator.sheetView()
            })
            .background(Color.Retro.gray4)
            .windowsBorder()
        }
    }
}

extension CustomCameraView: CameraViewDelegate {
    func processedImage(image: UIImage) {
        viewModel.capturedImage = image
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

//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomCameraView()
//    }
//}
