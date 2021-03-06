//
//    AlbumDetailsInteractorTests.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/30/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

@testable import NikeSampleiOS
import XCTest

class AlbumDetailsInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: AlbumDetailsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupAlbumDetailsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupAlbumDetailsInteractor() {
        sut = AlbumDetailsInteractor()
    }

    // MARK: Test doubles

    class PresenterSpy: AlbumDetailsPresentationLogic {
        var hasPresentAlbumBeenCalled = false
        var observePresentAlbumResponse: AlbumDetails.Response?
        func presentAlbum(response: AlbumDetails.Response) {
            hasPresentAlbumBeenCalled = true
            observePresentAlbumResponse = response
        }
    }

    // MARK: Tests

    let givenAlbumNoArtwork = Album(
        artistName: "artist",
        id: nil,
        releaseDate: nil,
        name: "name",
        kind: nil,
        copyright: nil,
        artistId: nil,
        contentAdvisoryRating: nil,
        artistUrl: nil,
        artworkUrl100: nil,
        genres: nil,
        url: nil)
    let givenAlbum = Album(
        artistName: "artist",
        id: nil,
        releaseDate: nil,
        name: "name",
        kind: nil,
        copyright: nil,
        artistId: nil,
        contentAdvisoryRating: nil,
        artistUrl: nil,
        artworkUrl100: "google.com",
        genres: nil,
        url: nil)

    func testFetchAlbumCallGetDataForAlbumArtwork() {
        // Given
        let dataFetcherSpy = DataFetcherSpy()
        sut.dataCache = dataFetcherSpy
        sut.album = givenAlbum
        // When
        sut.fetchAlbum()
        // Then
        XCTAssertTrue(dataFetcherSpy.hasGetDataBeenCalled,
                      "fetchAlbum should call getData for the artwork.")
    }
    func testPresenterIsCalledWitEvenWithNoArtwork() {
        // Given
        let presenterSpy = PresenterSpy()
        sut.presenter = presenterSpy
        sut.album = givenAlbumNoArtwork
        // When
        sut.fetchAlbum()
        // Then
        XCTAssertTrue(presenterSpy.hasPresentAlbumBeenCalled,
                      "Even when there is no artwork, we should present the album.")
        XCTAssertNil(presenterSpy.observePresentAlbumResponse?.artworkData,
                     "When we present artwork with no url, there should be no image data.")
    }
    func testPresenterIsCalledWithArtwork() {
        // Given
        let presenterSpy = PresenterSpy()
        sut.presenter = presenterSpy
        let dataFetcherSpy = DataFetcherSpy()
        let givenData = "Chello".data(using: .utf8) ?? Data()
        dataFetcherSpy.injectableGetDataResult = .success(givenData)
        sut.dataCache = dataFetcherSpy
        sut.album = givenAlbum
        // When
        sut.fetchAlbum()
        // Then
        XCTAssertTrue(presenterSpy.hasPresentAlbumBeenCalled,
                      "We should present the album with artwork.")
        XCTAssertNotNil(presenterSpy.observePresentAlbumResponse?.artworkData,
                     "When we present with  artwork there should be  image data.")
    }
}
