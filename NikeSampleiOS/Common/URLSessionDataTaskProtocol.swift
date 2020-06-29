//
//  URLSessionDataTaskProtocol.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//
import Foundation

/// Defines the methods we use out of the usual dataTask, so it can be injectable where needed.
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
}
