//
//  URLSessionProtocol.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

/// Protocol defining the methods we use out of the usual URLSession to make satisfy dependency injectiion
protocol URLSessionProtocol {
    /// A wrapper method to have our own dataTask that can be injectable where needed
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task = (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask)
        return task as URLSessionDataTaskProtocol
    }
}
