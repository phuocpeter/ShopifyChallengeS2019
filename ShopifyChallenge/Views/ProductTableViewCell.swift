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
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor(red: 92.0 / 255.0, green: 106.0 / 255.0, blue: 196.0 / 255.0, alpha: 0.85)
        selectedBackgroundView = selectedBackground
        nameLabel?.highlightedTextColor = .white
        collectionLabel?.highlightedTextColor = .white
        availabilityLabel?.highlightedTextColor = .white
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
