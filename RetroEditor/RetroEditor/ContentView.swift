//
//  ContentView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/07.
//

import SwiftUI
import PixelEngine

struct RectSettings: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            self.setView(proxy: geometry)
        }
    }

    func setView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func setImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//
//class test: ObservableObject {
//    @Published var filteredImage: CGImage? = nil
//    @Published var testBackgroundColor: Color? = nil
//
//    func startFilter() {
//        let lutImage = UIImage(named: "selfie-1")!
////        let target = UIImage(named: "TestImage")!
//
//        let target = CIImage(image: UIImage(named: "TestImage")!)
//        let filter = FilterColorCube(
//          name: "Filter",
//          identifier: "1",
//          lutImage: lutImage,
//          dimension: 64
//        )
//
//        let preview = PreviewFilterColorCube(sourceImage: target!, filter: filter)
//
////        let source = CIImage(image: target)!
////        let result = filter.apply(to: source, sourceImage: source)
//
//        filteredImage = preview.cgImage
//
//        testBackgroundColor = Color.blue
//    }
//}
//struct ContentView: View {
//    @ObservedObject var data: test = test()
//
//    var body: some View {
//        ZStack {
//            Image(uiImage: UIImage(cgImage: data.filteredImage ?? CIContext().createCGImage(CIImage(color: .black), from: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1920, height: 1080)))!))
//                .renderingMode(.original)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 68, height: 68)
//                .clipped()
//                .onAppear(perform: {
//                    data.startFilter()
//                })
//
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .background(Color.white)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
