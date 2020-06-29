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
        let genreJSON = JsonForTests.genreJSON
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
        let albumJSON = JsonForTests.albumJson
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
        XCTAssertNotNil(album?.url, "Creating an album from json should succeed with a valid url string.")
    }
}
