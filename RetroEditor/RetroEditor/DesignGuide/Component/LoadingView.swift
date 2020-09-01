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
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 0, trailing: 1))
            HStack {
                Image("icnSandglass")
                Spacer()
                Text("Loading...")
            }
            .padding(EdgeInsets(top: 30, leading: 41, bottom: 18, trailing: 41))

            // TODO: need animation
            HStack {
                Spacer()
                HStack(spacing: 1.7) {
                    Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
                    Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
                    Color.Retro.darkBlue.edgesIgnoringSafeArea(.all)
                }
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                .windowsBorder()
                Spacer()
            }
            .padding(.leading, 22)
            .padding(.trailing, 22)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 28,
                alignment: .leading
            )

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

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
