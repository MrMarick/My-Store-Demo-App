//
//  ProductJSONResponse.swift
//  iDine
//
//  Created by Karma Strategies on 24/07/24.
//

import Foundation
struct ProductJSONResponse: Codable{
    let status: Bool
    let message: String
    let error: String?
    let categories: [CategoriesData]
}

struct CategoriesData: Codable{
    let id: Int
    let name: String
    let items: [ItemData]
}

struct ItemData: Codable{
        let id: Int
        let name: String
        let icon: String
        let price: Double
}
