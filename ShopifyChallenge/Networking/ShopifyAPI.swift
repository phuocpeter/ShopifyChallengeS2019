//
//  ShopifyAPI.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

/// An interface that communicate with Shopify Challenge's endpoints.
class ShopifyAPI: API {

    /// Endpoint to fetch collections.
    private let CUSTOM_COLLECTION_URL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"

    /// Construct a url endpoint for collection detail.
    ///
    /// - Parameter collection: the collection that needs detail.
    /// - Returns: a url endpoint.
    private func getCollectURL(for collection: CustomCollection) -> URL? {
        return URL(string: "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collection.id)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
    }

    /// Construct a url endpoint for products detail.
    ///
    /// - Parameter ids: collection of product ids
    /// - Returns: a url endpoint.
    private func getProductURL(for ids: [Int]) -> URL? {
        let params = ids.map{ String($0) }.joined(separator: ",")
        return URL(string: "https://shopicruit.myshopify.com/admin/products.json?ids=\(params)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
    }

    func getCustomCollections(completion: @escaping CustomCollectionFetchResult) {
        let url = URL(string: CUSTOM_COLLECTION_URL)
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            // Handle error if exists
            guard error == nil else {
                return completion(nil, .networkError(error))
            }
            guard data != nil else {
                return completion(nil, .missingResponseData)
            }
            let json = try? JSONSerialization.jsonObject(with: data!)
            guard json != nil else {
                return completion(nil, .invalidData(message: "Failed to serialize response to JSON"))
            }
            // Convert response json into model objects.
            if let dict = json as? [String: Any],
                let collections = dict["custom_collections"] as? [[String: Any]] {
                    var result = [CustomCollection]()
                    for obj in collections {
                        if let collection = CustomCollection.init(json: obj) {
                            result.append(collection)
                        }
                    }
                    completion(result, nil)
            } else {
                completion(nil, .invalidData(message: "Response JSON is not in the expected format."))
            }
        }.resume()
    }

    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult) {
        let url = getCollectURL(for: collection)
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            // Handle error if exists
            guard error == nil else {
                return completion(nil, .networkError(error))
            }
            guard data != nil else {
                return completion(nil, .missingResponseData)
            }
            let json = try? JSONSerialization.jsonObject(with: data!)
            guard json != nil else {
                return completion(nil, .invalidData(message: "Failed to serialize response to JSON"))
            }
            // Convert json into model objects
            if let dict = json as? [String: Any],
                let array = dict["collects"] as? [[String: Any]] {
                var ids = [Int]()
                for obj in array {
                    if let productId = obj["product_id"] as? Int {
                        ids.append(productId)
                    }
                }
                self.getProducts(fromCollectIds: ids, collectionName: collection.title) { completion($0, $1) }
            } else {
                completion(nil, .invalidData(message: "Response JSON is not in the expected format."))
            }
        }.resume()
    }

    /// Fetches products from Shopify API.
    ///
    /// - Parameters:
    ///   - ids: collection of product ids.
    ///   - collection: the CustomCollection containing these products.
    ///   - completion: the completion handler when fetch completed.
    private func getProducts(fromCollectIds ids: [Int], collectionName collection: String, completion: @escaping ProductFetchResult) {
        let url = getProductURL(for: ids)
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            // Handle error if exists
            guard error == nil else {
                return completion(nil, .networkError(error))
            }
            guard data != nil else {
                return completion(nil, .missingResponseData)
            }
            let json = try? JSONSerialization.jsonObject(with: data!)
            guard json != nil else {
                return completion(nil, .invalidData(message: "Failed to serialize response to JSON"))
            }
            // Convert json to model objects
            if let dict = json as? [String: Any],
                let array = dict["products"] as? [[String: Any]] {
                var products = [Product]()
                for obj in array {
                    if let product = Product(json: obj, collectionName: collection) {
                        products.append(product)
                    }
                }
                completion(products, nil)
            } else {
                completion(nil, .invalidData(message: "Response JSON is not in the expected format."))
            }
        }.resume()
    }

}
