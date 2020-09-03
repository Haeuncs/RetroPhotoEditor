//
//  SearchBar.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/03.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @State var name: String = ""

    var body: some View {
        HStack(alignment: .center) {
            Image("icnSearchGray")
                .frame(width: 26, height: 26, alignment: .center)
                .padding(.leading, 12)
                .padding(.trailing, 12)
            TextField("Search Item", text: $name)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                .padding(.trailing, 12)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 42,
            maxHeight: 42,
            alignment: .center
        )
        .background(Color.Retro.gray4)
        .windowsBorderReverse()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
