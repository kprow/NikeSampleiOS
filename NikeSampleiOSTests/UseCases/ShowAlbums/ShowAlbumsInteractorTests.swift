//
//    ShowAlbumsInteractorTests.swift
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

class ShowAlbumsInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: ShowAlbumsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupShowAlbumsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupShowAlbumsInteractor() {
        sut = ShowAlbumsInteractor()
    }

    // MARK: Test doubles
    class WorkerSpy: ShowAlbumsWorkerProtocol {
        var hasFetchFromAPIBeenCalled = false
        var injectableFetchFromAPIResult: Result<[Album], Error>?
        func fetchFromAPI(_ completionHandler: @escaping (Result<[Album], Error>) -> Void) {
            hasFetchFromAPIBeenCalled = true
            if let result = injectableFetchFromAPIResult {
                completionHandler(result)
            }
        }
    }
    class PresenterSpy: ShowAlbumsPresentationLogic {
        var hasPresentAlbumsBeenCalled = false
        var observePresentAlbumsResponse: ShowAlbums.Fetch.Response?
        func presentAlbums(response: ShowAlbums.Fetch.Response) {
            hasPresentAlbumsBeenCalled = true
            observePresentAlbumsResponse = response
        }
        var hasPresentAlbumArtworkBeenCalled = false
        var observePresentAlbumArtwork: ShowAlbums.Fetch.ArtWork?
        func presentAlbumArtwork(artwork: ShowAlbums.Fetch.ArtWork) {
            hasPresentAlbumArtworkBeenCalled = true
            observePresentAlbumArtwork = artwork
        }
    }

    // MARK: Tests

    func testFetchAlbumsCallsFetchFromAPI() {
        // Given
        let workerSpy = WorkerSpy()
        sut.worker = workerSpy
        // When
        sut.fetchAlbums(request: ShowAlbums.Fetch.Request())
        // Then
        XCTAssertTrue(workerSpy.hasFetchFromAPIBeenCalled,
                      "When we call fetchAlbums on the interactor it should delegate to the worker.")
    }
    func testFetchAlbumsWithSuccessCallsPresentAlbums() {
        // Given
        let workerSpy = WorkerSpy()
        workerSpy.injectableFetchFromAPIResult = .success([])
        sut.worker = workerSpy
        let presenterSpy = PresenterSpy()
        sut.presenter = presenterSpy
        // When
        sut.fetchAlbums(request: ShowAlbums.Fetch.Request())
        // Then
        XCTAssertTrue(presenterSpy.hasPresentAlbumsBeenCalled,
                      "When we call fetchAlbums and we get a successful response we should call presentAlbums")
    }
}
