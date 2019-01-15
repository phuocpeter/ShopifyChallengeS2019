//
//  Collection.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class Collection {
    private let id: Int
    private let handle: String
    private let title: String


    init(id: Int, handle: String, title: String) {
        self.id = id
        self.handle = handle
        self.title = title
    }
}
