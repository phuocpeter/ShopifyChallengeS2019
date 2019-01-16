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

    init(id: Int, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let body = json["body_html"] as? String,
            let title = json["title"] as? String
            else {
                return nil
        }

        self.id = id
        self.body = body
        self.title = title
    }
}
