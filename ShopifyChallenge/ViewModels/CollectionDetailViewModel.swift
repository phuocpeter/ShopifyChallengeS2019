//
//  CollectionDetailViewModel.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class CollectionDetailViewModel {

    var isFetching = false
    private var api: API = ShopifyAPI()
    private var products: [Product]?
    var count: Int {
        get {
            return products?.count ?? 0
        }
    }
    var isLoaded: Bool {
        return products != nil
    }

    subscript(index: Int) -> Product? {
        get {
            return products?[index]
        }
    }

    func loadProducts(ofCollection collection: CustomCollection, completion: @escaping (Error?) -> ()) {
        guard !isFetching else { return }
        isFetching = true
        api.getProducts(for: collection) { (products, error) in
            guard error == nil else {
                completion(error!)
                return
            }
            guard products != nil else {
                return
            }
            self.products = products
            self.isFetching = false
            completion(nil)
        }
    }
}
