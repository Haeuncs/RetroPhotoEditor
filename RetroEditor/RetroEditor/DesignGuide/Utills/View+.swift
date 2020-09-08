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
    func windowsBorder(reverse: Bool = false) -> some View {
        if reverse {
            return AnyView(self.windowsBorderReverse())
        } else {
            return AnyView(self.windowsBorderDefault())
        }
    }

    func windowsBorderDefault() -> some View {
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

    func windowsBorderReverse() -> some View {
        self
            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
            .overlay(EmptyView().border(width: 2, edge: .leading, color: Color.Retro.wisteria))
            .overlay(EmptyView().border(width: 1, edge: .leading, color: Color.Retro.charcoalGrey))
            .overlay(EmptyView().border(width: 2, edge: .top, color: Color.Retro.wisteria))
            .overlay(EmptyView().border(width: 1, edge: .top, color: Color.Retro.charcoalGrey))
            .overlay(EmptyView().border(width: 2, edge: .trailing, color: Color.white))
            .overlay(EmptyView().border(width: 1, edge: .trailing, color: Color.Retro.gray4))
            .overlay(EmptyView().border(width: 2, edge: .bottom, color: Color.white))
            .overlay(EmptyView().border(width: 1, edge: .bottom, color: Color.Retro.gray4))

    }
}

extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)

        // locate far out of screen
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)

        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()

        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
}

struct ViewExtension_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .frame(width: 100, height: 100, alignment: .center)
            .windowsBorderReverse()
    }
}
