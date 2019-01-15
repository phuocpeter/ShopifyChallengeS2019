//
//  CollectionViewModel.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class CollectionViewModel {

    let api: MockAPI
    var collections: [CustomCollection]

    init() {
        api = MockAPI()
        collections = api.getCustomCollections()
    }

    func getProducts(forCollection collection: CustomCollection) -> [Product] {
        let collects = api.getCollect(ofCollection: collection)
        return api.getProducts(fromCollects: collects)
    }
}
