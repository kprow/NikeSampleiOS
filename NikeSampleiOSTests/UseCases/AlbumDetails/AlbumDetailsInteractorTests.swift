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

    // MARK: Tests

}
