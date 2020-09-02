//
//  SplashView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LoadingView()
                .padding(.leading, 24)
                .padding(.trailing, 24)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(Color.Retro.darkGreen.edgesIgnoringSafeArea(.all))
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
