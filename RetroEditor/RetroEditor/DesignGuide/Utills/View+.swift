//
//  View+.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/01.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

extension View {
    func border(width: CGFloat, edge: Edge, color: Color) -> some View {
        ZStack {
            self
            EdgeBorder(width: width, edge: edge).foregroundColor(color)
        }
    }

    // 커스텀한 windowsBorder
    func windowsBorder() -> some View {
        self
        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
        .overlay(EmptyView().border(width: 2, edge: .top, color: Color.white))
        .overlay(EmptyView().border(width: 1, edge: .top, color: Color.Retro.gray4))
        .overlay(EmptyView().border(width: 2, edge: .leading, color: Color.white))
        .overlay(EmptyView().border(width: 1, edge: .leading, color: Color.Retro.gray4))
        .overlay(EmptyView().border(width: 2, edge: .trailing, color: Color.Retro.wisteria))
        .overlay(EmptyView().border(width: 1, edge: .trailing, color: Color.Retro.charcoalGrey))
        .overlay(EmptyView().border(width: 2, edge: .bottom, color: Color.Retro.wisteria))
        .overlay(EmptyView().border(width: 1, edge: .bottom, color: Color.Retro.charcoalGrey))

    }
}