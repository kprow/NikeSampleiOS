//
//  UrlSessionMocks.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

@testable import NikeSampleiOS
import Foundation

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
