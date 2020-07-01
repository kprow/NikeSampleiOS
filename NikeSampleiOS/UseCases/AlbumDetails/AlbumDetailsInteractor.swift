//
//    AlbumDetailsInteractor.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/30/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

import UIKit

protocol AlbumDetailsBusinessLogic {
    func fetchAlbum()
}

protocol AlbumDetailsDataStore {
    var album: Album? { get set }
}

class AlbumDetailsInteractor: AlbumDetailsBusinessLogic, AlbumDetailsDataStore {
    var presenter: AlbumDetailsPresentationLogic?
    var album: Album?

    // MARK: Fetch Album

    func fetchAlbum() {
        // need to implement
    }
}
