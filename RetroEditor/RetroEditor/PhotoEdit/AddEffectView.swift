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
    @State var viewScale: ViewScale = .minimize

    @State var scrollPosition = 0.0
    private var gridItemLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    @ObservedObject var gifhyEvent: GifhyViewModel

    init(isPresented: Binding<Bool>, events: GifhyViewModel) {
        self._isPresented = isPresented
        self.gifhyEvent = events
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationView(
                isActiveView: $isPresented,
                viewScaleOption: $viewScale,
                closeButtonAction: {
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

            // handler 를 통하면?
            GiphyRepresentable(events: gifhyEvent)
        }
        .windowsBorder()
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: (viewScale == .maximize) ? .infinity : 500)
        .clipped()
        .shadow(color: Color.black.opacity(0.3), radius: 50, x: 0, y: 20)
    }
}

//struct AddEffectView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEffectView(isPresented: .constant(true), events: GifhySearch(query: "", mediaType: .stickers))
//    }
//}
