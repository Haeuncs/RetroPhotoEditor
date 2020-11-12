//
//  FilterListView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/01.
//

import SwiftUI

struct FilterCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("icnFish")
                    .resizable()
                    .scaledToFit()
                    .padding(EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    ))
            }
            HStack {
                Text("test")
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 20,
                alignment: .center
            )
            .windowsBorder(reverse: true)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(Color.Retro.gray4)
        .windowsBorder()
    }
}


struct StickerCell_Previews: PreviewProvider {
    static var previews: some View {
        FilterCell()
    }
}

struct FilterListView: View {
    enum Constant {
        static let gridItem = GridItem(.fixed(90))
        static let length: CGFloat = 90
    }

    var completion: (() ->Void)

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [Constant.gridItem], spacing: 0) {
                ForEach((0...999), id: \.self) { _ in
                    FilterCell()
                        .frame(
                            width: Constant.length,
                            height: Constant.length,
                            alignment: .center
                        )
                        .onTapGesture {
                            completion()
                        }
                }
            }
        }
        .windowsBorder()
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 90)
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView() {

        }
    }
}