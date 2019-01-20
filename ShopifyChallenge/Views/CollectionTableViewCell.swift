//
//  CollectionTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-19.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

/// A Table View Cell representing Collection Detail
class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?

    /// Display collection detail.
    ///
    /// - Parameters:
    ///   - collection: the collection to be displayed.
    func configure(for collection: CustomCollection) {
        self.titleLabel?.text = collection.title
        self.descriptionLabel?.text = collection.body
        collection.loadImageData {
            if let imageData = collection.imageData {
                DispatchQueue.main.async {
                    self.photoView?.image = UIImage(data: imageData)
                }
            }
        }
    }

}
