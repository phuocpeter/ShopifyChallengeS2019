//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class Product {
    let id: Int
    let title: String
    let body: String
    let available: Int

    init(id: Int, title: String, body: String, available: Int) {
        self.id = id
        self.title = title
        self.body = body
        self.available = available
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let body = json["body_html"] as? String,
            let title = json["title"] as? String,
            let variants = json["variants"] as? [[String: Any]]
            else {
                return nil
        }

        self.id = id
        self.body = body
        self.title = title
        var available = 0
        for variant in variants {
            if let quantity = variant["inventory_quantity"] as? Int {
                available += quantity
            }
        }
        self.available = available
    }
}
