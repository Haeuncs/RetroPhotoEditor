//
//  PhotoEditView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    // TODO: finish callback
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct PhotoEditView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var isPresented: Bool = false
    @State var isEffectPresented: Bool = false
    var image: UIImage

    init(image: UIImage) {
        self.image = image
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
                        WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                    }
                    Spacer()
                    Image(uiImage: self.image)
                        .resizable()
                        .background(Color.Retro.gray1)
                        .frame(
                            width: geometry.size.width - 4,
                            height: geometry.size.width - 4,
                            alignment: .center
                        )
                    Spacer()
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnTrash", text: "Delete All")
                        WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                        WindowsStyleButton(imageNamed: "icnFish", text: "Sticker")
                        WindowsStyleButton(imageNamed: "icnDisk", text: "Save") {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: self.image)
                        }
                    }
                }
                .background(Color.Retro.gray4)
                .windowsBorder()
            }
            if isEffectPresented {
                AddEffectView(isPresented: $isEffectPresented)
            }
        }
    }
}

struct TestView: View {
    var body: some View {
        GiphyRepresentable()
    }
}


struct PhotoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditView(image: UIImage())
    }
}
