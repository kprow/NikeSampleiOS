//
//  ModelsCreationTest.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import XCTest
@testable import NikeSampleiOS

class ModelsCreationTest: XCTestCase {

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
}
