//
//  PhotoEditView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI
import PixelEngine

class ImageSaver: NSObject {
    @Binding var imageSaveSuccessed: Bool

    init(imageSaveSuccessed: Binding<Bool>) {
        self._imageSaveSuccessed = imageSaveSuccessed
    }

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
            return
        }

        imageSaveSuccessed = true
    }
}

struct PhotoEditView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var imageSaveSuccessed = false
    @State var isPresented: Bool = false
    @State var isEffectPresented: Bool = false
    @State var currentSelectedSticker: Sticker? = nil
    @State var isFilterSelected: Bool = false

    @State var image: UIImage

    @State var testView: AnyView?
    @State var testRect: CGRect = .zero
    @ObservedObject var gifhyEvent = GifhyViewModel(search: GifhySearch(query: "", mediaType: .stickers))
    @ObservedObject var customCameraViewModel: CustomCameraViewModel


    init(image: UIImage, customCameraViewModel: CustomCameraViewModel) {
        self._image = State(initialValue: image)
        self.customCameraViewModel = customCameraViewModel
    }

    func getStickerView(length: CGFloat) -> AnyView {
        let view = ZStack {
            Image(uiImage: self.image)
                .resizable()
                .background(Color.Retro.gray1)
                .frame(
                    width: length,
                    height: length,
                    alignment: .center
                )
                .onTapGesture {
                    currentSelectedSticker = nil
                }

            StickerView(
                event: gifhyEvent,
                currentSelectedSticker: $currentSelectedSticker
            )
            .frame(
                width: length,
                height: length,
                alignment: .center
            )
        }
        .frame(
            width: length,
            height: length,
            alignment: .center
        )
        let wrapperView = HStack {
            view
        }
        .frame(
            width: length,
            height: length,
            alignment: .center
        )
        .onAppear {
            testView = AnyView(view)
        }

        return AnyView(wrapperView)
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    NavigationView(isActiveView: self.$isPresented) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnFish", text: "Sticker") {
                            self.isEffectPresented.toggle()
                        }
                        WindowsStyleButton(imageNamed: "icnFilter", text: "Filter") {
                            isFilterSelected.toggle()
                        }
                    }
                    Spacer()
                        getStickerView(length: geometry.size.width - 4)
                            .background(RectSettings(rect: $testRect))
                    Spacer()
                    if isFilterSelected {
                        FilterListView(completion: { imageAsset in
                            guard let ciImage = CIImage(image: customCameraViewModel.capturedImage!)?.oriented(forExifOrientation: Int32(customCameraViewModel.capturedImage!.imageOrientation.exifOrientation)) else {
                                return
                            }
                            let lutImage = imageAsset.image
                            let filter = FilterColorCube(
                                name: "Filter",
                                identifier: imageAsset.name,
                                lutImage: lutImage,
                                dimension: 64
                            )
                            let preview = PreviewFilterColorCube(sourceImage: ciImage, filter: filter)
                            self.image = UIImage(cgImage: preview.cgImage)
                        }, resetCompletion: {
                            self.image = customCameraViewModel.capturedImage!
                        })

                    }
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnTrash", text: "Delete All") {
                            gifhyEvent.stickers = []
                        }
                        WindowsStyleButton(imageNamed: "icnDisk", text: "Save") {
                            currentSelectedSticker = nil
                            if let image = UIApplication.shared.windows[0].rootViewController?.presentedViewController?.view.setImage(rect: self.testRect) {
                                let imageSaver = ImageSaver(imageSaveSuccessed: $imageSaveSuccessed)
                                imageSaver.writeToPhotoAlbum(image: image)
                            }
                        }
                    }
                }
                .background(Color.Retro.gray4)
                .windowsBorder()
            }
            if isEffectPresented {
                AddEffectView(isPresented: $isEffectPresented, events: gifhyEvent)
            }
            if imageSaveSuccessed {
                AlertView(dismiss: $imageSaveSuccessed, title: "저장 성공", leftText: "완료", leftCompletion: {
                    presentationMode.wrappedValue.dismiss()
                    customCameraViewModel.capturedImage = nil
                }, rightText: nil, rightCompletion: nil)
            }
        }
    }
}

struct PhotoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditView(image: UIImage(), customCameraViewModel: CustomCameraViewModel())
    }
}
