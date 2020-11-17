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

    @State var isPresented: Bool = true

    @State var showImageSavedSuccess = false
    @State var showStickerView: Bool = false
    @State var showFilterView: Bool = false

    @State var currentSelectedSticker: Sticker? = nil

    @State var image: UIImage
    @State var captureArea: CGRect = .zero

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

        return AnyView(wrapperView)
    }

    func saveDidTap() {
        currentSelectedSticker = nil
        if let image = UIApplication.shared.windows[0].rootViewController?.presentedViewController?.view.setImage(rect: self.captureArea) {
            let imageSaver = ImageSaver(imageSaveSuccessed: $showImageSavedSuccess)
            imageSaver.writeToPhotoAlbum(image: image)
        }
    }

    // TODO: 필터 적용된 이미지가 combine 같은걸로 작동되도록 변경해야함..
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    NavigationView(isActiveView: self.$isPresented) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    HStack(spacing:0) {
                        WindowsStyleButton(
                            image: UIImage.icnFish,
                            text: "Sticker",
                            isSelected: showStickerView
                        ) {
                            showStickerView.toggle()
                        }
                        WindowsStyleButton(
                            image: UIImage.icnFilter,
                            text: "Filter",
                            isSelected: showFilterView
                        ) {
                            showFilterView.toggle()
                        }
                    }
                    Spacer()
                        getStickerView(length: geometry.size.width - 4)
                            .background(RectSettings(rect: $captureArea))
                    Spacer()
                    if showFilterView {
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
                        WindowsStyleButton(
                            image: UIImage.icnTrash,
                            text: "Delete All"
                        ) {
                            gifhyEvent.stickers = []
                        }
                        WindowsStyleButton(
                            image: UIImage.icnDisk,
                            text: "Save"
                        ) {
                            saveDidTap()
                        }
                    }
                }
                .background(Color.Retro.gray4)
                .windowsBorder()
            }
            if showStickerView {
                SelectStickerView(isPresented: $showStickerView, events: gifhyEvent)
            }
            if showImageSavedSuccess {
                AlertView(
                    dismiss: $showImageSavedSuccess,
                    title: "저장 성공",
                    leftText: "완료",
                    leftCompletion: {
                        presentationMode.wrappedValue.dismiss()
                        customCameraViewModel.capturedImage = nil
                    },
                    rightText: nil,
                    rightCompletion: nil
                )
            }
        }
    }
}

struct PhotoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditView(image: UIImage(), customCameraViewModel: CustomCameraViewModel())
    }
}
