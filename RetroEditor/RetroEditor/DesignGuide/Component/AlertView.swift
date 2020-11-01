//
//  AlertView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/10/31.
//

import SwiftUI

struct AlertView: View {
    @Binding var dismiss: Bool

    var title: String
    var leftText: String?
    var leftCompletion: (()->Void)?
    var rightText: String?
    var rightCompletion: (()->Void)?

    init(
        dismiss: Binding<Bool>,
        title: String,
        leftText: String? = nil,
        leftCompletion: (()->Void)? = nil,
        rightText: String? = nil,
        rightCompletion: (()->Void)? = nil
    ) {
        self._dismiss = dismiss
        self.title = title
        self.leftText = leftText
        self.leftCompletion = leftCompletion
        self.rightText = rightText
        self.rightCompletion = rightCompletion
    }

    var body: some View {
        VStack {
            NavigationView(isActiveView: $dismiss, closeButtonAction: {
                dismiss = false
            })
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 0, trailing: 1))
            HStack {
                Text(title)
            }
            .padding(EdgeInsets(top: 30, leading: 41, bottom: 18, trailing: 41))

            HStack {
                if let leftText = self.leftText {
                    WindowsStyleButton(text: leftText) {
                        leftCompletion?()
                    }
                }

                if let rightText = self.rightText {
                    WindowsStyleButton(text: rightText) {
                        rightCompletion?()
                    }
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .center
        )
        .padding(.bottom, 30)
        .background(Color.Retro.gray4)
        .windowsBorder()
    }
}
