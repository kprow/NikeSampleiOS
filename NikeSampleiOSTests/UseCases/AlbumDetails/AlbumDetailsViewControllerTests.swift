//
//    AlbumDetailsViewControllerTests.swift
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

class AlbumDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test

    var sut: AlbumDetailsViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupAlbumDetailsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupAlbumDetailsViewController() {
        sut = AlbumDetailsViewController()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class InteractorSpy: AlbumDetailsBusinessLogic {
        var hasFetchAlbumBeenCalled = false
        func fetchAlbum() {
            hasFetchAlbumBeenCalled = true
        }
    }
    // MARK: Tests

    func testViewDidLoadCallsFetchAlbums() {
        // Given
        let interactorSpy = InteractorSpy()
        sut.interactor = interactorSpy
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(interactorSpy.hasFetchAlbumBeenCalled,
                      "When viewDidLoad is called we should fetchAlbum.")
    }
    static let testImage: UIImage? = {
         // Draw image
         let size = CGSize(width: 10, height: 10)
         UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
         // Capture renedered image
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return image
     }()
    let givenViewModel = AlbumDetails.ViewModel(
        name: "Album Name",
        artist: "Artist Name",
        artwork: AlbumDetailsViewControllerTests.testImage?.pngData(),
        genre: "Folk, Rock",
        releaseDate: "2020-05-05",
        copyright: "℗ 2020 Haim Productions Inc. under exclusive license to Columbia Records.",
        iTunesLink: URL(string: "https://music.apple.com/us/album/women-in-music-pt-iii/1500345235?app=itunes"))
    func testDisplayAlbumSetsViewAttributes() {
        // When
        sut.displayAlbum(viewModel: givenViewModel)
        // Then
        XCTAssertNotNil(sut.imageView.image, "displayAlbum should set the imageView.image.")
        XCTAssertEqual(givenViewModel.name, sut.albumNameLabel.text, "Unexpected view attribute.")
        XCTAssertEqual(givenViewModel.artist, sut.artistNameLabel.text, "Unexpected view attribute.")
        XCTAssertEqual(givenViewModel.genre, sut.genreLabel.text, "Unexpected view attribute.")
        XCTAssertEqual(givenViewModel.copyright, sut.copyrightLabel.text, "Unexpected view attribute.")
    }
}
