//
//  Model.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import Foundation

struct Item: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

struct Products: Decodable {
    let products: [Item]
    let total: Int
    let skip: Int
    let limit: Int
}
