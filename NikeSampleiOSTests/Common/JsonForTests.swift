//
//  JsonForTests.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation
struct JsonForTests {
    static let albumJson =
// swiftlint:disable line_length
"""
{
  "artistName": "HAIM",
  "id": "1500345235",
  "releaseDate": "2020-06-26",
  "name": "Women In Music Pt. III",
  "kind": "album",
  "copyright": "℗ 2020 Haim Productions Inc. under exclusive license to Columbia Records, a Division of Sony Music Entertainment",
  "artistId": "164483115",
  "contentAdvisoryRating": "Explicit",
  "artistUrl": "https://music.apple.com/us/artist/haim/164483115?app=itunes",
  "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/df/35/5a/df355aa6-edcb-2b68-ed7b-aa562d01049d/886448286899.jpg/200x200bb.png",
  "genres": [
    {
      "genreId": "20",
      "name": "Alternative",
      "url": "https://itunes.apple.com/us/genre/id20"
    },
    {
      "genreId": "34",
      "name": "Music",
      "url": "https://itunes.apple.com/us/genre/id34"
    }
  ],
  "url": "https://music.apple.com/us/album/women-in-music-pt-iii/1500345235?app=itunes"
}
"""
// swiftlint:enable line_length
    static let genreJSON =
"""
{
  "genreId": "20",
  "name": "Alternative",
  "url": "https://itunes.apple.com/us/genre/id20"
}
"""
    static let feedJSON =
"""
{
    "title": "Top Albums",
    "results": [
        \(JsonForTests.albumJson)
    ]
}
"""
    static let rssJSON = "{ \"feed\": \(JsonForTests.feedJSON) }"
}
