//
//  ITunesRSSFeedGenerator.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// Definition of how we make requests agains the iTunes API
protocol ITunesAPIProtocol {
    /// Fetches the data from the iTunes RSS feed generator
    /// - Parameter completionHandler: returns Data on success or an Error
    func fetchData(_ completionHandler: @escaping (Result<Data, Error>) -> Void)
}

/// Implementation of iTunes API
struct ITunesRSSFeedGenerator: ITunesAPIProtocol {

    /// The url used to fetch rss feed
    private let baseURL =
    "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"

    /// Dependency - the session used to perform dataTasks(requests)
    var session: URLSessionProtocol = URLSession.shared

    init() {}

    func fetchData(_ completionHandler: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: baseURL) {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { (data, _, error) in
                DispatchQueue.main.async {
                    if let err = error {
                        completionHandler(.failure(err))
                        return
                    }
                    guard let data = data else {
                        completionHandler(.failure(FeedError.noData))
                        return
                    }
                    completionHandler(.success(data))
                }
            }.resume()
        }
    }
}
extension ITunesRSSFeedGenerator {
    /// Error enum for the feed generator in case something goes wrong.
    enum FeedError: Error, Equatable {
        case noData
    }
}
