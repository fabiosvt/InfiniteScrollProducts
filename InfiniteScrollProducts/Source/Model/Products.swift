//
//  Products.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 02/10/22.
//

import Foundation

protocol PropertyLoopable {
    func allProperties() throws -> Array<Any>
}

struct Product: Codable, PropertyLoopable {
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

    static let instance: Product = Product()

    func value(for key: String) -> Any? {
        switch key {
        case "id": return id
        case "title": return self.title
        case "description": return self.description
        case "price": return self.price
        case "discountPercentage": return self.price
        case "rating": return self.rating
        case "stock": return self.stock
        case "brand": return self.brand
        case "category": return self.category
        case "thumbnail": return self.thumbnail
        case "images": return self.images
        default: fatalError("Invalid key")
        }
    }
}

struct Products: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

extension PropertyLoopable {
    func allProperties() throws -> Array<Any> {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            //throw some error
            throw NSError()
        }
        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }
            result[label] = valueMaybe
        }
        return result.sorted(by: { $0.key < $1.key })
    }
}
