////
////  TestView.swift
////  RetroEditor
////
////  Created by LEE HAEUN on 2020/09/04.
////  Copyright © 2020 LEE HAEUN. All rights reserved.
////
//
//import SwiftUI
//import Sliders
//
//struct MyView: View {
//
//    @State private var contentOffset: CGPoint = .zero
//    var text = """
//    Note, you can use anything to change the scrollPosition . In my case, I wanted to make a teleprompter app where the text scrolls over time, so I called the scrollTo function within a timer.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Thanks for reading my story — feel free to leave any questions in the comments, and give it a clap if it was useful! Otherwise, check out my other SwiftUI posts:
//    Note, you can use anything to change the scrollPosition . In my case, I wanted to make a teleprompter app where the text scrolls over time, so I called the scrollTo function within a timer.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Thanks for reading my story — feel free to leave any questions in the comments, and give it a clap if it was useful! Otherwise, check out my other SwiftUI posts:
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Note, you can use anything to change the scrollPosition . In my case, I wanted to make a teleprompter app where the text scrolls over time, so I called the scrollTo function within a timer.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Thanks for reading my story — feel free to leave any questions in the comments, and give it a clap if it was useful! Otherwise, check out my other SwiftUI posts:
//    Note, you can use anything to change the scrollPosition . In my case, I wanted to make a teleprompter app where the text scrolls over time, so I called the scrollTo function within a timer.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Thanks for reading my story — feel free to leave any questions in the comments, and give it a clap if it was useful! Otherwise, check out my other SwiftUI posts:
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//    Unfortunately, there isn’t a way to read out the scrollPosition in the other direction — if it changes by the user dragging the view up and down. So, for example, the slider won’t respond to the user dragging the text view up and down. Hopefully this changes in the future.
//
//    """
//
//    private var gridItemLayout = [
//        GridItem(.flexible(), spacing: 0),
//        GridItem(.flexible(), spacing: 0),
//        GridItem(.flexible(), spacing: 0),
//        GridItem(.flexible(), spacing: 0),
//        GridItem(.flexible(), spacing: 0)
//    ]
//    @State var isDrag: Bool = false
//    @State var scrollPosition = 0.0
//
//    @State private var isPresented = false
//
//    var body: some View {
//        Button("Present!") {
//            self.isPresented.toggle()
//        }
//        .fullScreenCover(isPresented: $isPresented) {
//            PhotoEditView()
//        }
//    }
//
////    var body: some View {
////        VStack(spacing: 0) {
////            SearchBar()
////            GeometryReader { geometry in
////                HStack(spacing: 0) {
////                    ScrollableView(self.$contentOffset, animationDuration: 0.5, isDrag: $isDrag) {
////                        LazyVGrid(columns: gridItemLayout, spacing: 0) {
////                            ForEach(0..<100, id: \.self) { index in
////                                StickerCell()
////                                    .frame(width: (geometry.size.width - 28) / 5, height: (geometry.size.width - 28) / 5)
////                            }
////                        }
////                    }
////                    VStack(spacing: 0) {
////                        Image("upperThumb")
////                            .resizable()
////                            .frame(width: 28, height: 28, alignment: .center)
////                        ValueSlider(value: $scrollPosition)
////                            .valueSliderStyle(
////                                VerticalValueSliderStyle(
////                                    track: Rectangle().fill(Color.Retro.gray1).frame(width: 28),
////                                    thumb: Rectangle().fill(Color.Retro.gray3).windowsBorder().rotationEffect(.degrees(180), anchor: .center),
////                                    thumbSize: CGSize(width: 28, height: 16)
////                                )
////                            )
////                            .rotationEffect(.degrees(180), anchor: .center)
////                        Image("lowerThumb")
////                            .resizable()
////                            .frame(width: 28, height: 28, alignment: .center)
////                    }
////                    .frame(maxWidth: 28, maxHeight: .infinity)
////                    .windowsBorder()
////                }
////            }
////        }
////        .windowsBorder()
////        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 500)
////        .clipped()
////        .shadow(color: Color.black.opacity(0.3), radius: 50, x: 0, y: 20)
////
////    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyView()
//    }
//}
