//
//  PhotoEditView.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/02.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    // TODO: finish callback
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct Sticker {
    var view: AnyView
    var point: CGPoint = .zero
    var newPosition: CGPoint = .zero
    var degree: Double = .zero
    var scale: CGFloat = 1
    var id: UUID = UUID()
}

struct TestStickerView: View {
    struct Position {
        var id = UUID()
        var position: CGSize
    }

    enum SimultaneousState {
        case inactive
        case rotating(angle: Angle)
        case zooming(scale: CGFloat)
        case both(angle: Angle, scale: CGFloat)

        var rotationAngle: Angle {
            switch self {
            case .rotating(let angle):
                return angle
            case .both(let angle, _):
                return angle
            default:
                return Angle.zero
            }
        }

        var scale: CGFloat {
            switch self {
            case .zooming(let scale):
                return scale
            case .both(_, let scale):
                return scale
            default:
                return CGFloat(1.0)
            }
        }
    }

    enum Constant {
        static var minimumScale: CGFloat = 0.7
    }

    @ObservedObject var gifhyEvent: GifhyViewModel
    @GestureState var simultaneousState = SimultaneousState.inactive
    @Binding var currentSelectedSticker: Sticker?

    let magnificationGesture = MagnificationGesture()
    let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))

    init(event: GifhyViewModel, currentSelectedSticker: Binding<Sticker?>) {
        self.gifhyEvent = event
        self._currentSelectedSticker = currentSelectedSticker
    }

    func reorderSticker(index: Int) {
        let currentSticker = gifhyEvent.stickers.remove(at: index)
        gifhyEvent.stickers.append(currentSticker)
    }

    var body: some View {
        // TODO: Improve this code....😭
        ZStack() {
            ForEach(gifhyEvent.stickers, id: \.id) { sticker in
                ZStack() {
                    sticker.view
                        .border(
                            Color.Retro.gray4.opacity(0.4),
                            width: (currentSelectedSticker?.id == sticker.id) ? 2 * (1/sticker.scale) : 0
                        )

                    if currentSelectedSticker?.id == sticker.id {
                        Button(action: {
                            gifhyEvent.removeSticker(id: sticker.id)
                        }) {
                            Image("icnXEllipse")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                        .frame(width: 26 * (1/sticker.scale), height: 26 * (1/sticker.scale), alignment: .leading)
                        .position(x: 140, y: 0)
                    }
                }
                .frame(width: 140, height:140)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(sticker.scale)
                .rotationEffect(Angle.degrees(sticker.degree))
                .offset(x: sticker.point.x, y: sticker.point.y)
                .onTapGesture {
                    currentSelectedSticker = sticker
                }
                .gesture(
                    DragGesture()
                        .onChanged({ (gesture) in
                            print(sticker)
                            let test = gesture.translation
                            print(test)
                            for index in 0..<gifhyEvent.stickers.count {
                                if gifhyEvent.stickers[index].id == sticker.id {
                                    let newPosition = gifhyEvent.stickers[index].newPosition
                                    gifhyEvent.stickers[index].point = CGPoint(
                                        x: newPosition.x + gesture.translation.width,
                                        y: newPosition.y + gesture.translation.height
                                    )
                                    reorderSticker(index: index)
                                    break
                                }
                            }
                        })
                        .onEnded { gesture in
                            for index in 0..<gifhyEvent.stickers.count {
                                if gifhyEvent.stickers[index].id == sticker.id {
                                    let newPosition = gifhyEvent.stickers[index].newPosition
                                    gifhyEvent.stickers[index].point = CGPoint(
                                        x: newPosition.x + gesture.translation.width,
                                        y: newPosition.y + gesture.translation.height
                                    )
                                    reorderSticker(index: index)
                                    gifhyEvent.stickers[index].newPosition = gifhyEvent.stickers[index].point
                                    break
                                }
                            }
                        }
                )
                .gesture(
                    SimultaneousGesture(magnificationGesture, rotationGesture)
                        .onChanged({ (value) in
                            for index in 0..<gifhyEvent.stickers.count {
                                let scale = (Constant.minimumScale <= value.first ?? 1) ? value.first ?? 1 : Constant.minimumScale
                                if gifhyEvent.stickers[index].id == sticker.id {
                                    gifhyEvent.stickers[index].scale = scale
                                    gifhyEvent.stickers[index].degree = value.second?.degrees ?? .zero
                                    reorderSticker(index: index)
                                }
                            }
                        })
                        .updating($simultaneousState) { value, state, transation in
                            if value.first != nil && value.second != nil {
                                state = .both(angle: value.second!, scale: value.first!)
                                print("Both")
                            } else if value.first != nil {
                                state = .zooming(scale: value.first!)
                                print("Zoom")
                            } else if value.second != nil {
                                state = .rotating(angle: value.second!)
                                print("Rotate")
                            } else {
                                state = .inactive
                            }
                        }
                        .onEnded { value in
                            for index in 0..<gifhyEvent.stickers.count {
                                if gifhyEvent.stickers[index].id == sticker.id {
                                    let scale = (Constant.minimumScale <= value.first ?? 1) ? value.first ?? 1 : Constant.minimumScale
                                    gifhyEvent.stickers[index].scale = scale
                                    gifhyEvent.stickers[index].degree = value.second?.degrees ?? .zero
                                    reorderSticker(index: index)
                                }
                            }
                        }
                )
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading
        )
        .clipped()

    }
}

struct PhotoEditView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var isPresented: Bool = false
    @State var isEffectPresented: Bool = false
    @State var currentSelectedSticker: Sticker? = nil
    var image: UIImage

    @State var testView: AnyView?
    @ObservedObject var gifhyEvent = GifhyViewModel(search: GifhySearch(query: "", mediaType: .stickers))

    init(image: UIImage) {
        self.image = image
    }

    func getStickerView(length: CGFloat) -> AnyView {
        let view = ZStack {
            Image(uiImage: self.image)
                .resizable()
                .background(Color.Retro.gray1)
                .frame(
                    width: length,
                    height: length,
                    alignment: .center
                )
                .onTapGesture {
                    currentSelectedSticker = nil
                }

            TestStickerView(
                event: gifhyEvent,
                currentSelectedSticker: $currentSelectedSticker
            )
            .frame(
                width: length,
                height: length,
                alignment: .center
            )
        }
        .frame(
            width: length,
            height: length,
            alignment: .center
        )
        let wrapperView = HStack {
            view
        }
        .frame(
            width: length,
            height: length,
            alignment: .center
        )
        .onAppear {
            testView = AnyView(view)
        }

        return AnyView(wrapperView)
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    NavigationView(isActiveView: self.$isPresented) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnFish", text: "Sticker") {
                            self.isEffectPresented.toggle()
                        }
                        WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                    }
                    Spacer()
                    getStickerView(length: geometry.size.width - 4)
                    Spacer()
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnTrash", text: "Delete All") {
                            gifhyEvent.stickers = []
                        }
                        WindowsStyleButton(imageNamed: "icnDisk", text: "Save") {
                            currentSelectedSticker = nil
                            if let view = testView {
                                let imageSaver = ImageSaver()
                                imageSaver.writeToPhotoAlbum(image: view.asImage())
                            }
                        }
                    }
                }
                .background(Color.Retro.gray4)
                .windowsBorder()
            }
            if isEffectPresented {
                AddEffectView(isPresented: $isEffectPresented, events: gifhyEvent)
            }
        }
    }
}

struct PhotoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditView(image: UIImage())
    }
}
