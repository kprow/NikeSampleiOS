//
//  ModelsCreationTests.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import XCTest
@testable import NikeSampleiOS

class ModelsCreationTests: XCTestCase {

    func testGenreIsCreatedWithJSON() {
        // Given
        let genreJSON =
"""
{
  "genreId": "20",
  "name": "Alternative",
  "url": "https://itunes.apple.com/us/genre/id20"
}
"""
        // When
        let genre = try? JSONDecoder().decode(Genre.self, from: genreJSON.data(using: .utf8) ?? Data())
        // Then
        XCTAssertNotNil(genre, "Creating a genre from json should succeed.")
        XCTAssertNotNil(genre?.genreId, "Creating a genre from json should succeed with valid id.")
        XCTAssertNotNil(genre?.name, "Creating a genre from json should succeed with valid name.")
        XCTAssertNotNil(genre?.url, "Creating a genre from json should succeed with valid url string.")
    }
    func testAlbumIsCreatedWithJson() {
        // Given
        let albumJSON =
// swiftlint:disable line_length
"""
{
  "artistName": "HAIM",
  "id": "1500345235",
  "releaseDate": "2020-06-26",
  "name": "Women In Music Pt. III",
  "kind": "album",
  "copyright": "℗ 2020 Haim Productions Inc. under exclusive license to Columbia Records, a Division of Sony Music Entertainment",
  "artistId": "164483115",
  "contentAdvisoryRating": "Explicit",
  "artistUrl": "https://music.apple.com/us/artist/haim/164483115?app=itunes",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/df/35/5a/df355aa6-edcb-2b68-ed7b-aa562d01049d/886448286899.jpg/200x200bb.png",
  "genres": [
    {
      "genreId": "20",
      "name": "Alternative",
      "url": "https://itunes.apple.com/us/genre/id20"
    },
    {
      "genreId": "34",
      "name": "Music",
      "url": "https://itunes.apple.com/us/genre/id34"
    }
  ],
  "url": "https://music.apple.com/us/album/women-in-music-pt-iii/1500345235?app=itunes"
}
"""
// swiftlint:enable line_length
        // When
        let album = try? JSONDecoder().decode(Album.self, from: albumJSON.data(using: .utf8) ?? Data())
        // Then
        XCTAssertNotNil(album, "Creating an album from json should succeed.")
        XCTAssertNotNil(album?.id, "Creating an album from json should succeed with a valid id.")
        // The following is used for the UITableViewCell
        XCTAssertNotNil(album?.name, "Creating an album from json should succeed with a valid name.")
        XCTAssertNotNil(album?.artistName, "Creating an album from json should succeed with a valid artist name.")
        XCTAssertNotNil(album?.artworkUrl100,
                        "Creating an album from json should succeed with a valid artwork attribute.")
        // The following is used for Details Screen
        XCTAssertNotNil(album?.genres, "Creating an album from json should succeed with a valid genres array.")
        XCTAssertNotNil(album?.genres?.first,
                        "Creating an album from json should succeed with a valid genres array that is not empty.")
        XCTAssertNotNil(album?.releaseDate, "Creating an album from json should succeed with a valid release date.")
        XCTAssertNotNil(album?.copyright, "Creating an album from json should succeed with a valid copyright string.")
    }
}
