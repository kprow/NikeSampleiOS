//
//  ITunesRSSFeedGeneratorTests.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import XCTest
@testable import NikeSampleiOS

class ITunesRSSFeedGeneratorTests: XCTestCase {

    // MARK: Subject under test

    var sut: ITunesRSSFeedGenerator!

    override func setUpWithError() throws {
        sut = ITunesRSSFeedGenerator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // MARK: Test doubles
    class URLSessionSpy: URLSessionProtocol {
        var hasDataTaskBeenCalled = false
        var injectableDataTaskReturn = URLSessionDataTaskSpy()
        var injectableDataTaskData: Data?
        var injectableDataTaskResponse: URLResponse?
        var injectableDataTaskError: Error?
        func dataTask(with request: URLRequest,
                      completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
            hasDataTaskBeenCalled = true
            completionHandler(injectableDataTaskData, injectableDataTaskResponse, injectableDataTaskError)
            return injectableDataTaskReturn
        }
    }
    class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
        var hasResumeBeenCalled = false
        func resume() {
            hasResumeBeenCalled = true
        }
    }
    func testFetchDataCallsDataTask() {
        // Given
        let sessionSpy = URLSessionSpy()
        sut.session = sessionSpy
        // When
        sut.fetchData({ _, _ in
            // do nothing
        })
        // Then
        XCTAssertTrue(sessionSpy.hasDataTaskBeenCalled,
                      "When we call fetchData we should use the dataTask from URLSession.")
    }
    func testFetchDataCallsResumeOnDataTask() {
        // Given
        let dataTaskSpy = URLSessionDataTaskSpy()
        let sessionMock = URLSessionSpy()
        sessionMock.injectableDataTaskReturn = dataTaskSpy
        sut.session = sessionMock
        // When
        sut.fetchData({ _, _ in
            // do nothing
        })
        // Then
        XCTAssertTrue(dataTaskSpy.hasResumeBeenCalled,
                      "After creating the dataTask in fetchData, we should call resume.")
    }
    func testFetchDataWithErrorCallsCompletionHandlerWithError() {
        // Given
        let sessionMock = URLSessionSpy()
        sessionMock.injectableDataTaskError = NSError(domain: "", code: 0, userInfo: nil)
        sut.session = sessionMock
        let completionExpectation = expectation(description: "fetchData should call completionHandler.")
        // When
        sut.fetchData { (_, error) in
            // Then
            XCTAssertNotNil(error)
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (err) in
            if let err = err {
                XCTFail("Waiting for expectation failed. \(err)")
            }
        }
    }
}
