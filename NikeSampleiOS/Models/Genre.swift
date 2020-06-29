//
//  Genre.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/28/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import Foundation

/// A Genre entity model consisting of an id, name and url string.
struct Genre: Equatable, Codable {
    let genreId: String?
    let name: String?
    let url: String?
}
