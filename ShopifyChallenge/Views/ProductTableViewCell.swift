//
//  ProductTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-16.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

/// A Table View Cell representing Product Detail
class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var collectionLabel: UILabel?
    @IBOutlet weak var availabilityLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionLabel?.layer.masksToBounds = true
        collectionLabel?.layer.cornerRadius = 8.0
    }

    /// Display product detail.
    ///
    /// - Parameters:
    ///   - product: the product to be displayed.
    func configure(for product: Product) {
        self.nameLabel?.text = product.title
        self.collectionLabel?.text = " \(product.collection) "
        self.descriptionLabel?.text = product.body
        if product.available > 1 {
            self.availabilityLabel?.text = "\(product.available) availables"
        } else {
            self.availabilityLabel?.text = "\(product.available) available"
        }
        product.loadImageData {
            if let imageData = product.imageData {
                DispatchQueue.main.async {
                    self.photoView?.image = UIImage(data: imageData)
                }
            }
        }
    }

}
