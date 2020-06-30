//
//  AlbumTableViewCell.swift
//  NikeSampleiOS
//
//  Created by Andrew Koprowski on 6/29/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import UIKit

/// The table view cell used to display albums
class AlbumTableViewCell: UITableViewCell {
    /// The reuse identifier used for this table view cell.
    static let reuseIdentifier = "albumTableViewCell"

    /// The image of the album used in this style table view cell.
    var albumImage: UIImage? {
        didSet {
            imageView?.image = albumImage
        }
    }

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: AlbumTableViewCell.reuseIdentifier)
        layoutImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutImageView()
    }

    private func layoutImageView() {
        if let imageView = imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(activityIndicator)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: heightAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            ])
            if imageView.image == nil {
                activityIndicator.startAnimating()
            }
        }
    }
}
