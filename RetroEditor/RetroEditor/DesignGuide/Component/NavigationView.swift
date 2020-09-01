//
//  NavigationView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/01.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0, content: {
                Image("icnFish")
                    .frame(width: 26, height: 26, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                Spacer()
                Button(action: {
                    // TODO: 버튼 이벤트 넣기
                }) {
                    Image("icnX")
                    .resizable()
                    .renderingMode(.original)
                }
                .frame(width: 32, height: 32, alignment: .center)
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
        .background(Color.Retro.gray2)
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
