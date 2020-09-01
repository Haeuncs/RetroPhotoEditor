//
//  LoadingView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/01.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            NavigationView()
            HStack {
                Image("icnSandglass")
                Spacer()
                Text("Loading...")
            }
            .padding(EdgeInsets(top: 30, leading: 41, bottom: 18, trailing: 41))

            HStack(spacing: 1.7) {
                Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
                Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
                Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
            }
            .padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 22))
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 24,
                alignment: .leading
            )
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .center
        )
        .background(Color.Retro.gray4)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
