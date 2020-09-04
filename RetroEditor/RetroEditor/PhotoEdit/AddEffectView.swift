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

class AddEffectScroll: ObservableObject {
    @Published var contentSize: CGSize = .zero
}

struct AddEffectView: View {

    @Binding var isPresented: Bool

    @State var scrollPosition = 0.0
    @State private var contentOffset: CGPoint = .zero

    var currentScrollContentSize: CGSize = .zero
    @State var isDrag: Bool = false

    @EnvironmentObject var scroll: AddEffectScroll

    private var gridItemLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationView(isActiveView: $isPresented, closeButtonAction: {
                isPresented.toggle()
            })
            SearchBar()
                .onTapGesture {

                }
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ScrollableView(
                        $contentOffset,
                        animationDuration: 0.5,
                        delegate: self,
                        isDrag: $isDrag,
                        content: {
                            LazyVGrid(columns: gridItemLayout, spacing: 0) {
                                ForEach(0..<100, id: \.self) { index in
                                    StickerCell()
                                        .frame(width: (geometry.size.width - 28) / 5, height: (geometry.size.width - 28)  / 5)
                                }
                            }
                        })
                        .onChange(of: scrollPosition) { newScrollPosition in
                            updateCurrentScrollOffset(ratio: newScrollPosition, frameHeight: geometry.size.height)
                        }
                        .onChange(of: contentOffset) { value in
                            updateCurrentScrollRate(scrollOffset: value, frameHeight: geometry.size.height)
                        }
                        .background(Color.Retro.gray4)
                        .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)

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

extension AddEffectView: ScrollableViewDelegate {
    func updateContentSize(size: CGSize) {
        if scroll.contentSize.height != size.height {
            scroll.contentSize = size
        }
    }
}

extension AddEffectView {
    func updateCurrentScrollRate(scrollOffset: CGPoint, frameHeight: CGFloat) {
        guard isDrag else {
            return
        }
        let currentScrollRatio = Double(scrollOffset.y/(scroll.contentSize.height - frameHeight))
        if 0 <= currentScrollRatio && currentScrollRatio <= 1 {
            scrollPosition = currentScrollRatio
        } else if currentScrollRatio < 0 {
            scrollPosition = 0
        } else {
            scrollPosition = 1
        }
    }

    func updateCurrentScrollOffset(ratio: Double, frameHeight: CGFloat) {
        contentOffset.y = (scroll.contentSize.height - frameHeight) * CGFloat(ratio)
    }
}

struct AddEffectView_Previews: PreviewProvider {
    static var previews: some View {
        AddEffectView(isPresented: .constant(true))
    }
}
