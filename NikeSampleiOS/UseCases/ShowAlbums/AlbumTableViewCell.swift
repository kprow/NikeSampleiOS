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

    /// The "loading" view for the image if it's not yet fetched
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: AlbumTableViewCell.reuseIdentifier)
        layoutTableViewCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutTableViewCell()
    }

    /// Method to use AutoLayout constraints to set the content correctly within the tableViewCell
    private func layoutTableViewCell() {
        if let imageView = imageView,
            let textLabel = textLabel,
            let detailTextLabel = detailTextLabel {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(activityIndicator)

            textLabel.translatesAutoresizingMaskIntoConstraints = false
            detailTextLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                // Image View Constraints
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: heightAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                // Text Label Constraints
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
                textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
                // Detail Text Label Constraints
                detailTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
                detailTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10.0),
                detailTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
            ])
            if imageView.image == nil {
                activityIndicator.startAnimating()
            }
        }
        accessoryType = .disclosureIndicator
    }
}
