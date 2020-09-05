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
    var point: CGPoint
    var degree: Double = .zero
    var scale: CGFloat = 1
    var id: UUID
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
//        static var minimumScale: Double = 4
    }

    @Binding var stickers: [Sticker]
    @State var stickerNewPositions: [CGSize] = []
    @GestureState var simultaneousState = SimultaneousState.inactive

    let magnificationGesture = MagnificationGesture()
    let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))

    init(stickers: Binding<[Sticker]>) {
        self._stickers = stickers
        _stickerNewPositions = State(initialValue: [CGSize](repeating: .zero, count: stickers.wrappedValue.count))
    }

    func reorderSticker(index: Int) {
        let currentSticker = stickers.remove(at: index)
        stickers.append(currentSticker)

        let currentStickerPosition = stickerNewPositions.remove(at: index)
        stickerNewPositions.append(currentStickerPosition)
    }

    var body: some View {

        ZStack() {
            ForEach(stickers, id: \.id) { sticker in
                sticker.view
                    .scaleEffect(sticker.scale)
                    .rotationEffect(Angle.degrees(sticker.degree))
                    .offset(x: sticker.point.x, y: sticker.point.y)
                    .frame(width: 100, height: 100)
                    .gesture(
                        DragGesture()
                            .onChanged({ (gesture) in
                                print(sticker)
                                let test = gesture.translation
                                print(test)
                                for index in 0..<stickers.count {
                                    if stickers[index].id == sticker.id {
                                        let newPosition = stickerNewPositions[index]
                                        stickers[index].point = CGPoint(
                                            x: newPosition.width + gesture.translation.width,
                                            y: newPosition.height + gesture.translation.height
                                        )

                                        reorderSticker(index: index)
                                        break
                                    }
                                }
                            })
                            .onEnded { gesture in
                                for index in 0..<stickers.count {
                                    if stickers[index].id == sticker.id {
                                        let newPosition = stickerNewPositions[index]
                                        stickers[index].point = CGPoint(
                                            x: newPosition.width + gesture.translation.width,
                                            y: newPosition.height + gesture.translation.height
                                        )
                                        reorderSticker(index: index)
                                        stickerNewPositions[index] = CGSize(width: stickers[index].point.x, height: stickers[index].point.y)
                                        break
                                    }
                                }
                            }
                    )
                    .gesture(
                        SimultaneousGesture(magnificationGesture, rotationGesture)
                            .onChanged({ (value) in
                                for index in 0..<stickers.count {
                                    if stickers[index].id == sticker.id {
                                        stickers[index].scale = value.first ?? 1
                                        stickers[index].degree = value.second?.degrees ?? .zero
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
                                for index in 0..<stickers.count {
                                    if stickers[index].id == sticker.id {
                                        stickers[index].scale = value.first ?? 1
                                        stickers[index].degree = value.second?.degrees ?? .zero
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
    var image: UIImage

    @ObservedObject var gifhyEvent = GifhyEvents(search: GifhySearch(query: "", mediaType: .stickers))
    @State var stickers: [Sticker] = [
        Sticker(view: AnyView(Rectangle().fill(Color.Retro.darkGray)), point: .zero, id: UUID()),
        Sticker(view: AnyView(Rectangle().fill(Color.Retro.darkBlue)), point: .zero, id: UUID()),
        Sticker(view: AnyView(Rectangle().fill(Color.Retro.darkGreen)), point: .zero, id: UUID())
    ]

    init(image: UIImage) {
        self.image = image
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
                    ZStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .background(Color.Retro.gray1)
                            .frame(
                                width: geometry.size.width - 4,
                                height: geometry.size.width - 4,
                                alignment: .center
                            )
                        TestStickerView(stickers: $stickers)
                            .frame(
                                width: geometry.size.width - 4,
                                height: geometry.size.width - 4,
                                alignment: .center
                            )
                    }
                    .frame(
                        width: geometry.size.width - 4,
                        height: geometry.size.width - 4,
                        alignment: .center
                    )
                    Spacer()
                    HStack(spacing:0) {
                        WindowsStyleButton(imageNamed: "icnTrash", text: "Delete All")
                        WindowsStyleButton(imageNamed: "icnFilter", text: "Filter")
                        WindowsStyleButton(imageNamed: "icnFish", text: "Sticker")
                        WindowsStyleButton(imageNamed: "icnDisk", text: "Save") {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: self.image)
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
