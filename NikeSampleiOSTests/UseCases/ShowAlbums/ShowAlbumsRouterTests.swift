//
//  ShowAlbumsRouterTests.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import XCTest
@testable import NikeSampleiOS

class ShowAlbumsRouterTests: XCTestCase {

    // MARK: Subject under test

    var sut: ShowAlbumsRouter!

    override func setUpWithError() throws {
        sut = ShowAlbumsRouter()
    }

    // MARK: Test doubles

    class SpyNavigationController: UINavigationController {
        var hasPushViewControllerBeenCalled = false
        var observePushViewController: UIViewController?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            hasPushViewControllerBeenCalled = true
            observePushViewController = viewController
        }
    }
    class DataStoreStub: ShowAlbumsDataStore {
        var albums: [Album] = [
            Album(
                artistName: "name",
                id: "id",
                releaseDate: "release date",
                name: "name",
                kind: "kind",
                copyright: "copyright",
                artistId: "artist id",
                contentAdvisoryRating: "contet advisory",
                artistUrl: "artistUrl",
                artworkUrl100: "artwork url",
                genres: [],
                url: "url")
        ]
    }

    // MARK: Tests

    func testRoutToAlbumDetailsPushesAlbumDetailsViewController() {
        // Given
        let navigationSpy = SpyNavigationController()
        let currentViewController = ShowAlbumsViewController(style: .plain)
        currentViewController.router = sut
        navigationSpy.addChild(currentViewController)
        sut.viewController = currentViewController
        sut.dataStore = DataStoreStub()
        // When
        sut.routeToAlbumDetails()
        // Then
        XCTAssert(navigationSpy.hasPushViewControllerBeenCalled,
                  "When we route to album details we should push onto the navigation stack.")
    }
}
