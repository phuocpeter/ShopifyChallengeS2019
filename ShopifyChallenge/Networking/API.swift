//
//  API.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

typealias CustomCollectionFetchResult = ([CustomCollection]?, Error?) -> ()
typealias ProductFetchResult = ([Product]?, Error?) -> ()

protocol API {
    func getCustomCollections(completion: @escaping CustomCollectionFetchResult)
    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult)
}
