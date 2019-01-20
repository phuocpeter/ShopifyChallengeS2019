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

/// An interface that communicate with a datasource and supplies collections and products.
protocol API {

    /// Fetches custom collections from the datasource.
    ///
    /// - Parameter completion: the completion handler to be called when fetch completed.
    func getCustomCollections(completion: @escaping CustomCollectionFetchResult)

    /// Fetches products from the datasource.
    ///
    /// - Parameters:
    ///   - collection: the CustomCollection object that these products belong to.
    ///   - completion: the completion handler to be called when fetch completed.
    func getProducts(for collection: CustomCollection, completion: @escaping ProductFetchResult)
}

/// Errors that can occur when performing API connections.
///
/// - networkError: occurs because of the device Internet connection.
/// - missingResponseData: occurs because the datasource delivers no reponse.
/// - invalidData: occurs because the data received from the datasource is in an unexpected format.
enum APIError: Error {
    case networkError(_ error: Error?)
    case missingResponseData
    case invalidData(message: String)
}

// MARK: - LocalizedError

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
