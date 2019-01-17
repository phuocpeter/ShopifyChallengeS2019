//
//  CollectionViewModel.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class CollectionViewModel {

    var isFetching = false
    private var api: API = ShopifyAPI()
    private var collection: [CustomCollection]?
    var count: Int {
        get {
            return collection?.count ?? 0
        }
    }

    subscript(index: Int) -> CustomCollection? {
        get {
            return collection?[index]
        }
    }

    func refreshData(completion: @escaping (APIError?) -> ()) {
        guard !isFetching else { return }
        isFetching = true
        api.getCustomCollections() { (collection, error) in
            self.isFetching = false
            guard error == nil else {
                return completion(error)
            }
            self.collection = collection
            completion(nil)
        }
    }
}
