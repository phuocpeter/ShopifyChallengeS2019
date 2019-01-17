//
//  MockAPI.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class MockAPI: API {

    func getCustomCollections(completion: @escaping CustomCollectionFetchResult) {
        var collection = [CustomCollection]()
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        completion(collection, nil)
    }

    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult) {
        var products = [Product]()
        products.append(Product(id: 2759137027, title: "Aerodynamic Concrete Clock", body: "Transition rich vortals", available: 100, collection: "Aerodynamic collection", imageURL: "https://placehold.it/80"))
        products.append(Product(id: 2759137027, title: "Aerodynamic Concrete Clock", body: "Transition rich vortals", available: 100, collection: "Aerodynamic collection", imageURL: "https://placehold.it/80"))
        products.append(Product(id: 2759137027, title: "Aerodynamic Concrete Clock", body: "Transition rich vortals", available: 100, collection: "Aerodynamic collection", imageURL: "https://placehold.it/80"))
        products.append(Product(id: 2759137027, title: "Aerodynamic Concrete Clock", body: "Transition rich vortals", available: 100, collection: "Aerodynamic collection", imageURL: "https://placehold.it/80"))
        completion(products, nil)
    }
}
