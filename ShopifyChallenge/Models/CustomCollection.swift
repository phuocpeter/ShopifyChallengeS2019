//
//  CustomCollection.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class CustomCollection {
    let id: Int
    let handle: String
    let title: String

    init(id: Int, handle: String, title: String) {
        self.id = id
        self.handle = handle
        self.title = title
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let handle = json["handle"] as? String,
            let title = json["title"] as? String
            else {
                return nil
        }

        self.id = id
        self.handle = handle
        self.title = title
    }
}
