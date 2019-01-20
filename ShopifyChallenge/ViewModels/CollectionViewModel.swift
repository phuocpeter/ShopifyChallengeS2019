//
//  CollectionViewModel.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

/// Manage a list of CustomCollection objects.
class CollectionViewModel {

    /// Whether the view model is waiting for response from the API.
    var isFetching = false

    /// Datasource.
    private var api: API = ShopifyAPI()

    /// Available CustomCollections.
    private var collection: [CustomCollection]?

    /// Number of available CustomCollections.
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

    /// Fetches data from API.
    ///
    /// - Parameter completion: the completion handler to be called when fetch completed.
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
