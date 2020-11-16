//
//  NavigatorProtocol.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/16.
//

import SwiftUI

protocol NavigatorProtocol: ObservableObject {
    var showSheet: Bool { get }
    func sheetView() -> AnyView?
}
