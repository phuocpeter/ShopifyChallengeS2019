//
//  CustomCollection.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

/// Custom Collection Model
class CustomCollection {

    /// Unique ID.
    let id: Int

    /// Description of the collection.
    let body: String

    /// Title of the collection
    let title: String

    /// URL string of product image.
    let imageURL: String

    /// Product image data. Needs to be fetched using loadImageData(completion:)
    var imageData: Data?

    init(id: Int, handle: String, title: String, imageURL: String) {
        self.id = id
        self.body = handle
        self.title = title
        self.imageURL = imageURL
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let body = json["body_html"] as? String,
            let title = json["title"] as? String,
            let image = json["image"] as? [String: Any],
            let imageURL = image["src"] as? String else {
                return nil
        }

        self.id = id
        self.body = body
        self.title = title
        self.imageURL = imageURL
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
