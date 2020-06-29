//
//    ShowAlbumsPresenterTests.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/28/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

@testable import NikeSampleiOS
import XCTest

class ShowAlbumsPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ShowAlbumsPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupShowAlbumsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupShowAlbumsPresenter() {
        sut = ShowAlbumsPresenter()
    }

    // MARK: Test doubles

    class ViewControllerSpy: ShowAlbumsDisplayLogic {
        var hasDisplayAlbumsBeenCalled = false
        var observedDisplayAlbumsVM: ShowAlbums.Fetch.ViewModel?
        func displayAlbums(viewModel: ShowAlbums.Fetch.ViewModel) {
            hasDisplayAlbumsBeenCalled = true
            observedDisplayAlbumsVM = viewModel
        }
    }

    // MARK: Tests

    let givenAlbum = Album(
        artistName: "Artist",
        id: "110",
        releaseDate: nil,
        name: "Album Name",
        kind: nil,
        copyright: nil,
        artistId: nil,
        contentAdvisoryRating: nil,
        artistUrl: nil,
        artworkUrl100: nil,
        genres: nil,
        url: nil)
    let givenUnkownAlbum = Album(
        artistName: nil,
        id: "110",
        releaseDate: nil,
        name: nil,
        kind: nil,
        copyright: nil,
        artistId: nil,
        contentAdvisoryRating: nil,
        artistUrl: nil,
        artworkUrl100: nil,
        genres: nil,
        url: nil)

    func testPresentAlbumsCallsDisplayAlbums() {
        // Given
        let vcSpy = ViewControllerSpy()
        sut.viewController = vcSpy
        let givenResponse = ShowAlbums.Fetch.Response(albums: [givenAlbum])
        // When
        sut.presentAlbums(response: givenResponse)
        // Then
        XCTAssertTrue(vcSpy.hasDisplayAlbumsBeenCalled,
                      "When we call presentAlbums we should call displayAlbums on the view controller")
        XCTAssertEqual(givenAlbum.name, vcSpy.observedDisplayAlbumsVM?.albums.first?.name,
                       "The name of the album in the view model should be that of the given album name.")
        XCTAssertEqual(givenAlbum.artistName, vcSpy.observedDisplayAlbumsVM?.albums.first?.artist,
                       "The artist of the album in the view model should be that of the given album artist.")
    }
    
}
