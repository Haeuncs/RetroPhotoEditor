//
//  NavigationView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/01.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

enum ViewScale {
    case maximize
    case minimize
    case none
}

struct NavigationView: View {
    let closeButtonAction: (() -> Void)?
    @Binding var isActiveView: Bool
    @Binding var viewScaleOption: ViewScale

    init(
        isActiveView: Binding<Bool> = .constant(false),
        closeButtonAction: (() -> Void)? = nil
    ) {
        self.closeButtonAction = closeButtonAction
        self._isActiveView = isActiveView
        self._viewScaleOption = Binding.constant(.none)
    }

    init(
        isActiveView: Binding<Bool> = .constant(false),
        viewScaleOption: Binding<ViewScale>,
        closeButtonAction: (() -> Void)? = nil
    ) {
        self.closeButtonAction = closeButtonAction
        self._isActiveView = isActiveView
        self._viewScaleOption = viewScaleOption
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0, content: {
                Image("icnFish")
                    .renderingMode(.template)
                    .foregroundColor(isActiveView ? Color.white : Color.Retro.darkGray)
                    .frame(width: 26, height: 26, alignment: .center)
                Spacer()
                HStack(spacing: 12) {
                    if viewScaleOption != .none {
                        Button(action: {
                            viewScaleOption = (viewScaleOption == .maximize) ? .minimize : .maximize
                        }) {
                            Image((viewScaleOption == .minimize) ? "icnMaximize" : "icnMinimize")
                            .resizable()
                            .renderingMode(.original)
                        }
                        .frame(width: 32, height: 32, alignment: .center)
                    }
                    Button(action: {
                        closeButtonAction?()
                    }) {
                        Image("icnX")
                        .resizable()
                        .renderingMode(.original)
                    }
                    .frame(width: 32, height: 32, alignment: .center)
                }
            })
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 44,
            maxHeight: 44,
            alignment: .center
        )
        .background(isActiveView ? Color.Retro.darkBlue : Color.Retro.gray2)
    }
}

struct NavigationView_Previews: PreviewProvider {
    @State static var isActive: Bool = false

    static var previews: some View {
        NavigationView(isActiveView: $isActive)
    }
}
