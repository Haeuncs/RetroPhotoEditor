//
//  Sticker.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/14.
//

import SwiftUI

struct Sticker {
    var view: AnyView
    var point: CGPoint = .zero
    var newPosition: CGPoint = .zero
    var degree: Double = .zero
    var scale: CGFloat = 1
    var id: UUID

    init(view:AnyView, uuid: UUID) {
        self.view = view
        self.id = uuid
    }
}
