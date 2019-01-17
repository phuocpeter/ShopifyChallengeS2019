//
//  API.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-15.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import Foundation

typealias CustomCollectionFetchResult = ([CustomCollection]?, APIError?) -> ()
typealias ProductFetchResult = ([Product]?, APIError?) -> ()

protocol API {
    func getCustomCollections(completion: @escaping CustomCollectionFetchResult)
    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult)
}

enum APIError: Error {
    case networkError(_ error: Error?)
    case missingResponseData
    case invalidData(message: String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network Error: \(error?.localizedDescription ?? "Error")"
        case .missingResponseData:
            return "Response from server is empty"
        case .invalidData(let message):
            return "Invalid data: \(message)"
        }
    }
}
