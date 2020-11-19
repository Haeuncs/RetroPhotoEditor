//
//  WindowsStyleButton.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct WindowsStyleButton: View {

    let action: (() -> Void)?
    let icnImage: UIImage?
    let text: String
    let isSelected: Bool

    init(
        image: UIImage? = nil,
        text: String,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.icnImage = image
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }

    var body: some View {
        Button(action: {
            self.action?()
        }) {
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    if let image = icnImage {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 26, height: 26, alignment: .center)
                    }
                    Text(text)
                        .font(Font.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(Color.Retro.darkGray)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 62,
                alignment: .center
            )
            .background(isSelected ? Color.Retro.gray4 : Color.Retro.gray3)
            .windowsBorder(reverse: isSelected)
        }
    }
}

struct WindowsStyleButton_Previews: PreviewProvider {
    static var previews: some View {
        WindowsStyleButton(image: UIImage.icnCrop, text: "Crop")
    }
}
