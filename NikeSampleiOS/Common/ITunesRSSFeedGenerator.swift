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
    func fetchData(_ completionHandler: @escaping (Data?, Error?) -> Void)
}

/// Implementation of iTunes API
struct ITunesRSSFeedGenerator: ITunesAPIProtocol {

    private let baseURL =
    "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"

    /// Dependency - the session used to perform dataTasks(requests)
    var session: URLSessionProtocol = URLSession.shared

    init() {}

    func fetchData(_ completionHandler: @escaping (Data?, Error?) -> Void) {
        if let url = URL(string: baseURL) {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { (data, _, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                    return
                }
            }.resume()
        }
    }
}
