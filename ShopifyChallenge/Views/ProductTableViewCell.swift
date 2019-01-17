//
//  ProductTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-16.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var collectionLabel: UILabel?
    @IBOutlet weak var availabilityLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(for product: Product, in tableView: UITableView, at indexPath: IndexPath) {
        self.nameLabel?.text = product.title
        self.collectionLabel?.text = product.collection
        self.availabilityLabel?.text = "Total Available: \(product.available)"
        product.loadImageData {
            if let imageData = product.imageData {
                DispatchQueue.main.async {
                    self.photoView?.image = UIImage(data: imageData)
                }
            }
        }
    }

}
