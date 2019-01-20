//
//  CollectionDetailViewModel.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

/// Manages list of products.
class CollectionDetailViewModel {

    /// Whether the view model is waiting for response from the API.
    var isFetching = false

    /// The collection that these products are belonged to.
    var collection: CustomCollection?

    /// Datasource.
    private var api: API = ShopifyAPI()

    /// Available products.
    private var products: [Product]?

    /// The number of available products.
    var count: Int {
        get {
            return products?.count ?? 0
        }
    }

    /// Whether data fetch has been done.
    var isLoaded: Bool {
        return collection != nil && products != nil
    }

    subscript(index: Int) -> Product? {
        get {
            return products?[index]
        }
    }

    /// Fetches products from API.
    ///
    /// - Parameters:
    ///   - collection: the collection of the products.
    ///   - completion: the completion handler to be called when fetch completed.
    func loadProducts(ofCollection collection: CustomCollection, completion: @escaping (Error?) -> ()) {
        guard !isFetching else { return }
        isFetching = true
        self.collection = collection
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
