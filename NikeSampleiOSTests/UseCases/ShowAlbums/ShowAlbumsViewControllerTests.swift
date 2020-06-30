//
//    ShowAlbumsViewControllerTests.swift
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

class ShowAlbumsViewControllerTests: XCTestCase {
    // MARK: Subject under test

    var sut: ShowAlbumsViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupShowAlbumsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupShowAlbumsViewController() {
        sut = ShowAlbumsViewController(style: .plain)
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class ShowAlbumsInteractorSpy: ShowAlbumsBusinessLogic {
        var hasFetchAlbumsBeenCalled = false
        func fetchAlbums(request: ShowAlbums.Fetch.Request) {
            hasFetchAlbumsBeenCalled = true
        }
    }
    class RouterSpy: ShowAlbumsRoutingLogic, ShowAlbumsDataPassing {
        var dataStore: ShowAlbumsDataStore?

        var hasRoutToAlbumDetailsBeenCalled = false
        func routeToAlbumDetails() {
            hasRoutToAlbumDetailsBeenCalled = true
        }
    }

    // MARK: Tests
    func testViewDidLoadSetsTitle() {
        // Given
        let expectedTitle = Constants.showAlbmusVCTitle
        // When
        loadView()
        // Then
        XCTAssertEqual(expectedTitle, sut.title,
                       "The title of the \(expectedTitle) should be set in viewDidLoad")
    }
    func testViewDidLoadCallsFetchAlbums() {
        // Given
        let interactorSpy = ShowAlbumsInteractorSpy()
        sut.interactor = interactorSpy
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(interactorSpy.hasFetchAlbumsBeenCalled,
                      "When viewDidLoad is called we should fetchAlbums.")
    }
    func testDisplayAlbumsSetsAlbumsUpForDisplay() {
        // Given
        let albumVM = ShowAlbums.Fetch.ViewModel.Album(name: "Name", artist: "Artist")
        let viewModel = ShowAlbums.Fetch.ViewModel(albums: [albumVM])
        // When
        sut.displayAlbums(viewModel: viewModel)
        // Then
        XCTAssertEqual(albumVM.name, sut.albums.first?.name,
                       "The displayAlbums method should set up the albums array in the vc.")
        XCTAssertEqual(albumVM.artist, sut.albums.first?.artist,
                       "The displayAlbums method should set up the albums array in the vc.")
    }
    func testDisplayAlbumsCallsReloadData() {
        // Given
        let tableViewSpy = UITableViewSpy()
        sut.tableView = tableViewSpy
        // When
        sut.displayAlbums(viewModel: ShowAlbums.Fetch.ViewModel(albums: []))
        // Then
        XCTAssertTrue(tableViewSpy.hasReloadDataBeenCalled,
                      "displayAlbums should call reload data on the tableview.")
    }
    func testNumberOfRowsInSectionReturnsViewModelCount() {
        // Given
        loadView()
        let albumList = [
            ShowAlbums.Fetch.ViewModel.Album(name: "1", artist: "artist 1"),
            ShowAlbums.Fetch.ViewModel.Album(name: "2", artist: "artist 2")
        ]
        sut.albums = albumList
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        // Then
        XCTAssertEqual(albumList.count, numberOfRows,
                       "the number of rows in the only section should be the same as the number of albums.")
    }
    func testRegisterIsCalledOnTableViewInViewDidLoad() {
        // Given
        let tableViewSpy = UITableViewSpy()
        sut.tableView = tableViewSpy
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(tableViewSpy.hasRegisterBeenCalled, "We should register the tableview in viewDidLoad")
        XCTAssertEqual(AlbumTableViewCell.reuseIdentifier, tableViewSpy.observerRegisterCellReuseId,
                       "The tableView cell should be registered with the given reuse identifier.")
    }
    func testCellForRowAtCallsDequeue() {
        // Given
        let tableViewSpy = UITableViewSpy()
        sut.tableView = tableViewSpy
        sut.albums = [ShowAlbums.Fetch.ViewModel.Album(name: "album", artist: "artist")]
        // When
        _ = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertTrue(tableViewSpy.hasDequeueBeenCalled,
                      "We should dequeue a table view cell in cell for row at for better memory management.")
        XCTAssertEqual(AlbumTableViewCell.reuseIdentifier, tableViewSpy.observeDequeuIdentifier,
                       "We should dequeu a table view cell with the given identifer for reuse.")
    }
    func testCellForRowAtSetsTextLabelWithAlbumName() {
        // Given
        let givenName = "Album"
        let givenArtist = "Artist"
        sut.albums = [ShowAlbums.Fetch.ViewModel.Album(name: givenName, artist: givenArtist)]
        // When
        let observedCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertEqual(givenName, observedCell.textLabel?.text,
                       "We should set the textLabel to be the the given album name.")
        XCTAssertEqual(givenArtist, observedCell.detailTextLabel?.text,
                       "We should set the detail text labe to be the the given artist name.")
    }
    func testDisplayAlbumArtworkSetsAlbumImageData() {
        // Given
        sut.albums = [ShowAlbums.Fetch.ViewModel.Album(name: "name", artist: "artist")]
        let tableViewSpy = UITableViewSpy()
        sut.tableView = tableViewSpy
        let artwork = ShowAlbums.Fetch.ArtWork(imageData: Data(), index: 0)
        // When
        sut.displayAlbumArtwork(artwork: artwork)
        // Then
        XCTAssertNotNil(sut.albums.first?.imageData,
                        "After calling display artwork, the image data for that album should not be nil.")
        XCTAssertTrue(tableViewSpy.hasReloadDataBeenCalled,
                      "We should also reload data after displayArtwork is called so the cells are updated.")
    }
    let testImage: UIImage? = {
        // Draw image
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        // Capture renedered image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
    func testCellForRowAtSetsImageArtwork() {
        // Given
        let imageData = testImage?.pngData()
        let artwork = ShowAlbums.Fetch.ViewModel.Album(name: "name", artist: "artist", imageData: imageData)
        sut.albums = [artwork]
        // When
        let observedCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            as? AlbumTableViewCell
        // Then
        XCTAssertNotEqual(UIImage(), observedCell?.albumImage,
                          "If image data is set in the current album, we should not have a default image.")
    }
    func testTableCellPrepareForReuseSetsAlbumImageToNil() {
        // Given
        let albumTVC = AlbumTableViewCell()
        albumTVC.albumImage = UIImage()
        // When
        albumTVC.prepareForReuse()
        // Then
        XCTAssertNil(albumTVC.albumImage,
                     "When we prepare a cell for re use we should set the album image back to nil.")
    }
    func testDidSelectRowAtRoutesToAlbumDetails() {
        // Given
        let routerSpy = RouterSpy()
        sut.router = routerSpy
        sut.albums = [ShowAlbums.Fetch.ViewModel.Album(
            name: "name",
            artist: "artist",
            imageData: nil)]
        // When
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertTrue(routerSpy.hasRoutToAlbumDetailsBeenCalled,
            "When we select an album from the list, we should route to the Album Details scene.")
    }
}
