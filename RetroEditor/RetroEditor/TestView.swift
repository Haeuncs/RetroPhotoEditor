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
//
//
//    var body: some View {
//            ScrollableView(self.$contentOffset, animationDuration: 0.5) {
//                LazyVGrid(columns: gridItemLayout, spacing: 0) {
//                    ForEach(0..<100, id: \.self) { index in
//                        Rectangle()
//                            .frame(width: (300) / 5, height: (300) / 5)
//                    }
//                }
//            }, isDrag: <#Binding<Bool>#>
//            .frame(width: 300, height: 500, alignment: .center)
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyView()
//    }
//}
