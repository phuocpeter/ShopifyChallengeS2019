//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

/// Product Model.
class Product {

    /// Unique ID.
    let id: Int

    /// Product title.
    let title: String

    /// Name of the collection of the product.
    let collection: String

    /// Description of the product.
    let body: String

    /// Number of available products across all variants.
    let available: Int

    /// URL string of product image.
    let imageURL: String

    /// Product image data. Needs to be fetched using loadImageData(completion:)
    var imageData: Data?

    init(id: Int, title: String, body: String, available: Int, collection: String, imageURL: String) {
        self.id = id
        self.title = title
        self.body = body
        self.available = available
        self.collection = collection
        self.imageURL = imageURL
    }

    init?(json: [String: Any], collectionName collection: String) {
        guard let id = json["id"] as? Int,
            let body = json["body_html"] as? String,
            let title = json["title"] as? String,
            let variants = json["variants"] as? [[String: Any]],
            let image = json["image"] as? [String: Any],
            let imageURL = image["src"] as? String else {
                return nil
        }

        self.id = id
        self.body = body
        self.title = title
        self.collection = collection
        self.imageURL = imageURL
        var available = 0
        for variant in variants {
            if let quantity = variant["inventory_quantity"] as? Int {
                available += quantity
            }
        }
        self.available = available
    }

    /// Load image from imageURL if it needed.
    ///
    /// - Parameter completion: the completion handler to be called when fetch completed.
    func loadImageData(completion: @escaping () -> ()) {
        guard imageData == nil else { return completion() }
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard error == nil else { return }
                self.imageData = data
                completion()
            }.resume()
        }
    }
}
