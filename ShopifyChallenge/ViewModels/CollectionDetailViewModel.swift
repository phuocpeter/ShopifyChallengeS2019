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
    private var api: API = MockAPI()
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

    func loadProducts(ofCollection collection: CustomCollection, completion: @escaping () -> ()) {
        guard !isFetching else { return }
        isFetching = true
        api.getProducts(for: collection) { (products, error) in
            guard error == nil else { return }
            guard products != nil else { return }
            self.products = products
            self.isFetching = false
            completion()
        }
        /*api.getCollects(ofCollection: collection) { (collects, error) in
            guard error == nil else { return }
            guard collects != nil else { return }
            self.api.getProducts(fromCollects: collects!) { (products, error) in
                guard error == nil else { return }
                self.products = products
                self.isFetching = false
                completion()
            }
        }*/
    }
}
