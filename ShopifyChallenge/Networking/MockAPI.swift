//
//  MockAPI.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class MockAPI {

    func getCustomCollections() -> [CustomCollection] {
        var collection = [CustomCollection]()
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        collection.append(CustomCollection(id: 68424466488, handle: "aerodynamic-collection", title: "Aerodynamic collection"))
        print("Loaded collection")
        return collection
    }

}
