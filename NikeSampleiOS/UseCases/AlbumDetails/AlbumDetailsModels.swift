//
//    AlbumDetailsModels.swift
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

enum AlbumDetails {
    struct Response {
        let album: Album
        let artworkData: Data?
    }
    struct ViewModel {
        let name: String
        let artist: String
        let artwork: Data?
        let genre: String
        let releaseDate: String
        let copyright: String
        let iTunesLink: URL?
    }
}
