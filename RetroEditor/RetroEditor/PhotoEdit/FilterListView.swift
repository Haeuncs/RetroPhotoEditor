//
//  FilterListView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/01.
//

import SwiftUI

struct FilterCell: View {
    @State var fileterImage: ImageAsset
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(uiImage: fileterImage.image)
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
                Text(fileterImage.name)
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

struct FilterResetCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("원본")
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



//struct StickerCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterCell()
//    }
//}

struct FilterListView: View {
    enum Constant {
        static let gridItem = GridItem(.fixed(90))
        static let length: CGFloat = 90
    }

    var completion: ((ImageAsset) ->Void)
    var resetCompletion: (()->Void)

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [Constant.gridItem], spacing: 0) {
                FilterResetCell()
                    .onTapGesture {
                        resetCompletion()
                    }
                ForEach(Asset.allImages, id: \.self) { imageAsset in
                    FilterCell(fileterImage: imageAsset)
                        .frame(
                            width: Constant.length,
                            height: Constant.length,
                            alignment: .center
                        )
                        .onTapGesture {
                            completion(imageAsset)
                        }
                }
            }
        }
        .windowsBorder()
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 90)
    }
}

//struct FilterListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterListView() {
//
//        }
//    }
//}
