//
//  RetroEditorApp.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/07.
//

import SwiftUI
import GiphyUISDK
import GiphyCoreSDK

@main
struct RetroEditorApp: App {
    var body: some Scene {
        WindowGroup {
            CustomCameraView()
                .onAppear(perform: {
                    Giphy.configure(apiKey: "MUnpNUdo2VzAW83dE7aEPHM3C79SSFmJ")
                })
        }
    }
}
