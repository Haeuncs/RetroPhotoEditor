//
//  WindowsStyleButton.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct WindowsStyleButton: View {
    var body: some View {
        Button(action: {
            // TODO: Event
        }) {
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    Image("icnCrop")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 26, height: 26, alignment: .center)
                    Text("test")
                        .font(Font.system(size: 14))
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
        WindowsStyleButton()
    }
}
