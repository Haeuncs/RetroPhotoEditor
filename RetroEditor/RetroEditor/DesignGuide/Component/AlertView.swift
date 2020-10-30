//
//  AlertView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/10/31.
//

import SwiftUI

struct AlertView: View {
    @Binding var dismiss: Bool
    let completion: (() -> Void)

    init(dismiss: Binding<Bool>, completion: @escaping (()->Void)) {
        self._dismiss = dismiss
        self.completion = completion
    }

    var body: some View {
        VStack {
            NavigationView(isActiveView: $dismiss, closeButtonAction: {
                completion()
            })
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 0, trailing: 1))
            HStack {
                Text("저장 성공!")
            }
            .padding(EdgeInsets(top: 30, leading: 41, bottom: 18, trailing: 41))

            WindowsStyleButton(text: "확인") {
                completion()
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
