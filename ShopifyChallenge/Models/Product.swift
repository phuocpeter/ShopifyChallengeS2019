//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class Product {
    private let id: Int
    private let title: String
    private let body: String

    init(id: Int, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
}
