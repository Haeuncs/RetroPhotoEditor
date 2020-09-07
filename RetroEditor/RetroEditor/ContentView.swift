//
//  ContentView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/07.
//

import SwiftUI
import PixelEngine

class test: ObservableObject {
    @Published var filteredImage: UIImage? = nil

    func startFilter() {
        let lutImage = UIImage(named: "neutral-lut-1")!
        let target = UIImage(named: "TestImage")!

        let filter = FilterColorCube(
          name: "Filter",
          identifier: "1",
          lutImage: lutImage,
          dimension: 64
        )

        let source = CIImage(image: target)!
        let result = filter.apply(to: source, sourceImage: source)
        let uiimage = UIImage(ciImage: result)

        filteredImage = uiimage
    }
}
struct ContentView: View {
    @ObservedObject var data: test = test()
    var body: some View {
        Image(uiImage: data.filteredImage ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .onAppear(perform: {
                data.startFilter()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
