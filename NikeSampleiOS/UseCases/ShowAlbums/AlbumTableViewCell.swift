//
//  AlbumTableViewCell.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/29/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import UIKit
class AlbumTableViewCell: UITableViewCell {
    static let reuseIdentifier = "albumTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: AlbumTableViewCell.reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        super.init(style: .subtitle, reuseIdentifier: AlbumTableViewCell.reuseIdentifier)
    }
}
