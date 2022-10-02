//
//  Products.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import Foundation

struct Product: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Double?
    var discountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var brand: String?
    var category: String?
    var thumbnail: String?
    var images: [String]?
}

struct Products: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
