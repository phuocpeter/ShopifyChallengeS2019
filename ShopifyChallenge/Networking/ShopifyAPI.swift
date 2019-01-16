//
//  ShopifyAPI.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

class ShopifyAPI: API {

    private let CUSTOM_COLLECTION_URL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"

    private func getCollectURL(for collection: CustomCollection) -> URL? {
        return URL(string: "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collection.id)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
    }

    private func getProductURL(for ids: [Int]) -> URL? {
        let params = ids.map{ String($0) }.joined(separator: ",")
        return URL(string: "https://shopicruit.myshopify.com/admin/products.json?ids=\(params)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
    }

    func getCustomCollections(completion: @escaping CustomCollectionFetchResult) {
        let url = URL(string: CUSTOM_COLLECTION_URL)
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!)
                    if let dict = json as? [String: Any] {
                        if let cc = dict["custom_collections"] as? [[String: Any]] {
                            var res = [CustomCollection]()
                            for obj in cc {
                                if let col = CustomCollection.init(json: obj) {
                                    res.append(col)
                                }
                            }
                            completion(res, nil)
                            return
                        }
                    }
                    completion(nil, nil)
                    return
                } catch {
                    completion(nil, error)
                }
            }
            completion(nil, nil)
        }.resume()
    }

    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult) {
        let url = getCollectURL(for: collection)
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            guard data != nil else {
                completion(nil, NSError(domain: "shopifyAPIError", code: 2, userInfo: nil))
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!)
            guard json != nil else {
                completion(nil, NSError(domain: "shopifyAPIError", code: 3, userInfo: nil))
                return
            }
            if let dict = json as? [String: Any],
                let array = dict["collects"] as? [[String: Any]] {
                var ids = [Int]()
                for obj in array {
                    if let productId = obj["product_id"] as? Int {
                        ids.append(productId)
                    }
                }
                self.getProducts(fromCollectIds: ids) { (data, err) in
                    completion(data, err)
                }
            }
            }.resume()
    }

    private func getProducts(fromCollectIds ids: [Int], completion: @escaping ProductFetchResult) {
        let url = getProductURL(for: ids)
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard err == nil else {
                completion(nil, err)
                return
            }
            guard data != nil else {
                completion(nil, NSError(domain: "shopifyAPIError", code: 2, userInfo: nil))
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!)
            guard json != nil else {
                completion(nil, NSError(domain: "shopifyAPIError", code: 3, userInfo: nil))
                return
            }
            if let dict = json as? [String: Any],
                let array = dict["products"] as? [[String: Any]] {
                var products = [Product]()
                for obj in array {
                    if let product = Product(json: obj) {
                        products.append(product)
                    }
                }
                completion(products, nil)
            }
        }.resume()
    }

}
