//
//  AddEffectView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/03.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI
import Combine
import Sliders

struct StickerCell: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("icnFish")
                .resizable()
                .padding(EdgeInsets(top: 13, leading: 13, bottom: 13, trailing: 13))
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
//        StickerCell()
//    }
//}

struct StickerTypeButton: View {
    var isSelected: Bool
    var text: String
    var completion: (() ->Void)
    init(text: String, isSelected: Bool, completion: @escaping () -> Void) {
        self.text = text
        self.isSelected = isSelected
        self.completion = completion
    }

    var body: some View {
        Button(action: {
            completion()
        }) {
            Text(text)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 42,
            maxHeight: 42,
            alignment: .center
        )
        .background(isSelected ? Color.Retro.gray3 : Color.Retro.gray4)
        .windowsBorder(reverse: isSelected)

    }
}
struct AddEffectView: View {

    @Environment(\.presentationMode) var presentationMode

    @Binding var isPresented: Bool

    @State var scrollPosition = 0.0
    private var gridItemLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    private let lazyVGridId = "AddEffectView_LazyVGrid"


//    @State var currentSearch

    @ObservedObject var gifhyEvent: GifhyEvents

    init(isPresented: Binding<Bool>, events: GifhyEvents) {
        self._isPresented = isPresented
        self.gifhyEvent = events
    }


    var body: some View {
        VStack(spacing: 0) {
            NavigationView(closeButtonAction: {
                isPresented.toggle()
            })
            SearchBar(events: gifhyEvent)
            HStack(spacing: 0) {
                ForEach(MediaType.allCases, id: \.self) { type in
                    StickerTypeButton(
                        text: type.rawValue,
                        isSelected: type == gifhyEvent.gifhySearch.mediaType
                    ) {
                        gifhyEvent.gifhySearch.mediaType = type
                    }
                }
            }
            GiphyRepresentable(events: gifhyEvent)
        }
        .windowsBorder()
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 500)
        .clipped()
        .shadow(color: Color.black.opacity(0.3), radius: 50, x: 0, y: 20)
    }
}

extension AddEffectView {
    /// get current scroll ratio then set position for custom slider
    private func updateCurrentScrollSliderValue(_ changes: CurrentViewRatio) {
        if let currentRate = changes[lazyVGridId] {
            if 0 <= currentRate && currentRate <= 1  {
                scrollPosition = currentRate
            } else if currentRate < 0 {
                scrollPosition = 0
            } else if currentRate > 1 {
                scrollPosition = 1
            }
        }
    }
}

//struct AddEffectView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEffectView(isPresented: .constant(true), events: GifhySearch(query: "", mediaType: .stickers))
//    }
//}
