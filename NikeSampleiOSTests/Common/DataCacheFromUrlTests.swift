//
//  DataCacheFromUrlTests.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import XCTest
@testable import NikeSampleiOS

class DataCacheFromUrlTests: XCTestCase {

    // MARK: Subject under test

    var sut: DataCacheFromUrl!

    override func setUpWithError() throws {
        sut = DataCacheFromUrl()
    }

    // MARK: Tests

    func testGetDataCallsDataTask() {
        // Given
        guard let url = URL(string: "google.com") else {
            XCTFail("Unable to create url.")
            return
        }
        let sessionSpy = URLSessionSpy()
        sut.session = sessionSpy
        // When
        sut.getData(from: url) { (_) in
            // do nothing
        }
        // Then
        XCTAssertTrue(sessionSpy.hasDataTaskBeenCalled,
                      "When we call getData we should use the dataTask from URLSession.")
    }
    func testGetDataCallsResumeOnDataTask() {
        // Given
        guard let url = URL(string: "google.com") else {
            XCTFail("Unable to create url.")
            return
        }
        let dataTaskSpy = URLSessionDataTaskSpy()
        let sessionMock = URLSessionSpy()
        sessionMock.injectableDataTaskReturn = dataTaskSpy
        sut.session = sessionMock
        // When
        sut.getData(from: url) { _ in
            // do nothing
        }
        // Then
        XCTAssertTrue(dataTaskSpy.hasResumeBeenCalled,
                      "After creating the dataTask in getData, we should call resume.")
    }
}
