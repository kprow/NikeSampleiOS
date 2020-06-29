//
//  ITunesRSSFeedResults.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/29/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// The model used to parse the json as it's given by the iTunes RSS Feed Generator
struct ITunesRss: Codable {
    let feed: ITunesRssFeed?
}

/// The model used for feed json returned by the iTunes RSS Feed Generator
struct ITunesRssFeed: Codable {
    let title: String?
    let results: [Album]?
}
