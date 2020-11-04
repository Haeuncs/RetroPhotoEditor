//
//  FilterListView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/01.
//

import SwiftUI

struct FilterListView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var gridItemLayout = [GridItem(.fixed(90))]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 20) {
                ForEach(symbols, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 90)
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView()
    }
}
