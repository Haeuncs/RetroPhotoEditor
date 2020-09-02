//
//  PhotoEditView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct PhotoEditView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationView()
                HStack(spacing:0) {
                    WindowsStyleButton(imageNamed: "icnFish", text: "Sticker")
                    WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                }
                Spacer()
                Image(uiImage: UIImage())
                    .resizable()
                    .background(Color.Retro.gray1)
                    .frame(
                        width: geometry.size.width - 4,
                        height: geometry.size.width - 4,
                        alignment: .center
                    )
                Spacer()
                HStack(spacing:0) {
                    WindowsStyleButton(imageNamed: "icnFish", text: "Sticker")
                    WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                    WindowsStyleButton(imageNamed: "icnFish", text: "Sticker")
                    WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                }
            }
            .background(Color.Retro.gray4)
            .windowsBorder()
        }
    }
}

struct PhotoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditView()
    }
}
