//
//  ITunesRSSFeedResults.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/29/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// The model used for feed json returned by the iTunes RSS Feed Generator
struct ITunesRssFeed: Codable {
    let title: String?
    let results: ITunesRssResults?
}

/// The model used for results returned by the iTunes RSS feed 'results' attribute.
struct ITunesRssResults: Codable {
    let results: [Album]?
}
