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

struct GiphyRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GiphyGridWrapperViewController {
        let giphy = GiphyGridWrapperViewController()
        return giphy
    }

    typealias UIViewControllerType = GiphyGridWrapperViewController

//    func makeCoordinator() -> () {
//
//    }

//    func makeUIViewController(context: Context) -> some UIViewController {
//        let giphy = GiphyViewController()
//        return giphy
//    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

class GiphyGridWrapperViewController: UIViewController {

    var gridController: GiphyGridController = {
        let controller = GiphyGridController()
        // space between cells
        controller.cellPadding = 2.0

        // the scroll direction of the grid
        controller.direction = .vertical

        // the number of "tracks" is the span count. it represents num columns for vertical grids & num rows for horizontal grids
        controller.numberOfTracks = 5

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

        gridController.content = GPHContent.search(withQuery: "Sup", mediaType: .text, language: .english)
        gridController.update()

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
    
}
