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
    let imageNamed: String
    let text: String
    init(imageNamed: String, text: String, action: (() -> Void)? = nil) {
        self.imageNamed = imageNamed
        self.text = text
        self.action = action
    }

    var body: some View {
        Button(action: {
            self.action?()
        }) {
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    Image(imageNamed)
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 26, height: 26, alignment: .center)
                    Text(text)
                        .font(Font.system(size: 14))
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
                .background(Color.Retro.gray3)
                .windowsBorder()
        }
    }
}

struct WindowsStyleButton_Previews: PreviewProvider {
    static var previews: some View {
        WindowsStyleButton(imageNamed: "icnCrop", text: "Crop")
    }
}
