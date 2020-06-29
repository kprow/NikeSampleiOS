//
//  Album.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// An Album entity model consisting of attributes provided in the json by the iTunes RSS feed.
/// This includes an array of genres
struct Album: Equatable, Codable {
    let artistName: String?
    // swiftlint:disable identifier_name
    let id: String?
    // swiftlint:enable identifier_name
    let releaseDate: String?
    let name: String?
    let kind: String?
    let copyright: String?
    let artistId: String?
    let contentAdvisoryRating: String?
    let artistUrl: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
}
