//
//  DataFetcherMock.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

@testable import NikeSampleiOS
import Foundation

class DataFetcherSpy: DataFetcher {
    static var dataCache = NSCache<AnyObject, AnyObject>()

    var hasGetDataBeenCalled = false
    var observeGetDataUrl: URL?
    var injectableGetDataResult: Result<Data, Error>?
    func getData(from url: URL, _ completionHandler: @escaping (Result<Data, Error>) -> Void) {
        hasGetDataBeenCalled = true
        observeGetDataUrl = url
        if let result = injectableGetDataResult {
            completionHandler(result)
        }
    }
}
