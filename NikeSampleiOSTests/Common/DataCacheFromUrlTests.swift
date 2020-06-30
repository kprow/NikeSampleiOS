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
    func testGetDataWithErrorCallsCompletionHandlerWithError() {
        // Given
        guard let url = URL(string: "google.com") else {
            XCTFail("Unable to create url.")
            return
        }
        let sessionMock = URLSessionSpy()
        sessionMock.injectableDataTaskError = NSError(domain: "", code: 0, userInfo: nil)
        sut.session = sessionMock
        let completionExpectation = expectation(description: "fetchData should call completionHandler.")
        // When
        sut.getData(from: url) { (result) in
            // Then
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("If there is no data we should not have success.")
            }
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (err) in
            if let err = err {
                XCTFail("Waiting for expectation failed. \(err)")
            }
        }
    }
    func testFetchDataWithNoDataCallsCompletionHandlerWithError() {
        // Given
        guard let url = URL(string: "google.com") else {
            XCTFail("Unable to create url.")
            return
        }
        let sessionMock = URLSessionSpy()
        sessionMock.injectableDataTaskData = nil
        sut.session = sessionMock
        let completionExpectation = expectation(description: "fetchData should call completionHandler.")
        // When
        sut.getData(from: url) { (result) in
            // Then
            switch result {
            case .failure(let error):
                XCTAssertTrue(error is DataCacheFromUrl.DataError,
                               "The error returned in the completion handler should be the DataError")
                XCTAssertEqual( .noData, error as? DataCacheFromUrl.DataError,
                           "The error returned in the completion handler should be .noData")
            case .success:
                XCTFail("If there is no data we should not have success.")
            }
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (err) in
            if let err = err {
                XCTFail("Waiting for expectation failed. \(err)")
            }
        }
    }
}
