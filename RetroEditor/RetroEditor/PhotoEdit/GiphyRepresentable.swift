//
//  GiphyRepresentable.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/09/05.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import SwiftUI
import GiphyUISDK
import GiphyCoreSDK
import SDWebImageSwiftUI

enum MediaType: String, CaseIterable {
    case stickers = "Stickers"
    case text = "Text"
    case gif = "Gif"
}

struct GifhySearch {
    var query: String
    var mediaType: MediaType
}

//// Giphy 관련 Action 정의
protocol GiphyGridWrapperViewControllerDelegate {
    func search(query: String, mediaType: MediaType)
}

class GifhyViewModel: ObservableObject {
    @Published var gifhySearch: GifhySearch
    @Published var stickers: [Sticker] = []
    
    init(search: GifhySearch) {
        gifhySearch = search
    }

    func addSticker(urlString: String) {
        let uuid = UUID()
        let view = AnimatedImage(url: URL(string: urlString))
            .onFailure { error in
                self.removeSticker(id: uuid)
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            .indicator(SDWebImageActivityIndicator.medium)
            .transition(.fade)
//            .scaledToFit() // Attention to call it on AnimatedImage, but not `some View` after View Modifier (Swift Protocol Extension method is static dispatched)
            .resizable()
            .scaledToFit()


        let newSticker = Sticker(view: AnyView(view), uuid: uuid)
        stickers.append(newSticker)
    }

    func removeSticker(id: UUID) {
        var deleteIndex: Int?
        for index in 0..<stickers.count {
            if stickers[index].id == id {
                deleteIndex = index
                break
            }
        }
        if let index = deleteIndex {
            stickers.remove(at: index)
        }
    }
}

struct GiphyRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = GiphyGridWrapperViewController
    @ObservedObject var events: GifhyViewModel

    init(events: GifhyViewModel) {
        self.events = events
    }

    func makeUIViewController(context: Context) -> GiphyGridWrapperViewController {
        let giphy = GiphyGridWrapperViewController()
        giphy.delegate = context.coordinator
        return giphy
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.search(gifhySearch: events.gifhySearch)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GPHGridDelegate {
        func didSelectMoreByYou(query: String) {

        }

        var parent: GiphyRepresentable

        init(_ parent: GiphyRepresentable) {
            self.parent = parent
        }
        
        func contentDidUpdate(resultCount: Int) {

        }

        func didSelectMedia(media: GPHMedia, cell: UICollectionViewCell) {
            if let webpURL = media.url(rendition: .original, fileType: .gif) {
                parent.events.addSticker(urlString: webpURL)
            }
        }


    }
}

class GiphyGridWrapperViewController: UIViewController {

    deinit {
        print("GiphyGridWrapperViewController deinit")
    }

    weak var delegate: GPHGridDelegate?
    var gridController: GiphyGridController = {
        let controller = GiphyGridController()
        // space between cells
        controller.cellPadding = 2.0

        // the scroll direction of the grid
        controller.direction = .vertical

        // the number of "tracks" is the span count. it represents num columns for vertical grids & num rows for horizontal grids
        controller.numberOfTracks = 3

        // hide the checkered background for stickers if you'd like (true by default)
//        controller.showCheckeredBackground = false
        controller.view.backgroundColor = .lightGray

        // by default, the waterfall layout sizes cells according to the aspect ratio of the media
        // the fixedSizeCells setting makes it so each cell is square
        // this setting only applies to Stickers (not GIFs)
        controller.fixedSizeCells = true
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()

        gridController.delegate = delegate
    }

    func configureLayout() {
        addChild(gridController)
        view.addSubview(gridController.view)

        gridController.view.translatesAutoresizingMaskIntoConstraints = false

        gridController.view.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        gridController.view.rightAnchor.constraint(equalTo: view.safeRightAnchor).isActive = true
        gridController.view.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        gridController.view.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
    }

    func search(gifhySearch: GifhySearch) {
        switch gifhySearch.mediaType {
        case .stickers:
            gridController.content = gifhySearch.query.isEmpty
                ? GPHContent.trending(mediaType: .sticker)
                : GPHContent.search(withQuery: gifhySearch.query, mediaType: .sticker, language: .english)
        case .gif:
            gridController.content = gifhySearch.query.isEmpty
                ? GPHContent.trending(mediaType: .gif)
                : GPHContent.search(withQuery: gifhySearch.query, mediaType: .gif, language: .english)
        case .text:
            gridController.content = gifhySearch.query.isEmpty
                ? GPHContent.trending(mediaType: .text)
                : GPHContent.search(withQuery: gifhySearch.query, mediaType: .text, language: .english)
        }
        gridController.update()

    }
}
