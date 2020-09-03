//
//  AddEffectView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/03.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI
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

struct AddEffectView: View {

    @Environment(\.presentationMode) var presentationMode

    @State var scrollPosition = 0.0
    private var gridItemLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    private let lazyVGridId = "AddEffectView_LazyVGrid"

    var body: some View {
        VStack(spacing: 0) {
            NavigationView(closeButtonAction: {
                presentationMode.wrappedValue.dismiss()
            })
            SearchBar()
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ScrollView {
                        ScrollViewReader { scrollProxy in
                            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                                ForEach(0..<100, id: \.self) { index in
                                    StickerCell()
                                        .frame(width: (geometry.size.width - 28) / 5, height: (geometry.size.width - 28)  / 5)
                                }
                            }
                            .provideFrameChanges(viewId: lazyVGridId)
                            .id(lazyVGridId)
                            .onChange(of: scrollPosition) { newScrollPosition in
                                scrollProxy.scrollTo(
                                    lazyVGridId,
                                    anchor: UnitPoint(x: 0, y: CGFloat(newScrollPosition))
                                )
                            }

                        }
                    }
                    .handleCurrentScrollRate {
                        updateCurrentScrollSliderValue($0)
                    }
                    .background(Color.Retro.gray4)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)

                    VStack(spacing: 0) {
                        Image("upperThumb")
                            .resizable()
                            .frame(width: 28, height: 28, alignment: .center)
                        ValueSlider(value: $scrollPosition)
                            .valueSliderStyle(
                                VerticalValueSliderStyle(
                                    track: Rectangle().fill(Color.Retro.gray1).frame(width: 28),
                                    thumb: Rectangle().fill(Color.Retro.gray3).windowsBorder().rotationEffect(.degrees(180), anchor: .center),
                                    thumbSize: CGSize(width: 28, height: 16)
                                )
                            )
                            .rotationEffect(.degrees(180), anchor: .center)
                        Image("lowerThumb")
                            .resizable()
                            .frame(width: 28, height: 28, alignment: .center)
                    }
                    .frame(maxWidth: 28, maxHeight: .infinity)
                    .windowsBorder()
                }
            }
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

struct AddEffectView_Previews: PreviewProvider {
    static var previews: some View {
        AddEffectView()
    }
}
