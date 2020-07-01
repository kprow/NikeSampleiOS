//
//  DataCacheFromUrl.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// Definition of DataFetcher used to get data from a url.
/// In our case we use this to get album artwork.
protocol DataFetcher {
    /// The cache used for data to NOT be requested every time from a url.
    static var dataCache: NSCache<AnyObject, AnyObject> { get }

    /// Main method of data fetcher to get data from cache if it exists or otherwise a url.
    /// - Parameters:
    ///   - url: the url to get data from
    ///   - completionHandler: a closure result consisitng of the data or an error.
    func getData(from url: URL, _ completionHandler: @escaping (Result<Data, Error>) -> Void)
}
class DataCacheFromUrl: DataFetcher {
    static let dataCache = NSCache<AnyObject, AnyObject>()

    /// Dependency - the session used to perform dataTasks(requests)
    var session: URLSessionProtocol = URLSession.shared

    func getData(from url: URL, _ completionHandler: @escaping (Result<Data, Error>) -> Void) {
        if let cahcedData = DataCacheFromUrl.dataCache.object(forKey: url as AnyObject) as? Data {
            completionHandler(.success(cahcedData))
        } else {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { (data, _, error) in
                DispatchQueue.main.async {
                    if let err = error {
                        completionHandler(.failure(err))
                        return
                    }
                    guard let data = data else {
                        completionHandler(.failure(DataError.noData))
                        return
                    }
                    // Happy case 😃
                    DataCacheFromUrl.dataCache.setObject(data as AnyObject, forKey: url as AnyObject)
                    completionHandler(.success(data))
                }
            }.resume()
        }
    }
}
extension DataCacheFromUrl {
    enum DataError: Error {
        case noData
    }
}
