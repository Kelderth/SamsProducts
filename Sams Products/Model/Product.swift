//
//  Product.swift
//  Sams Products
//
//  Created by MCS on 12/24/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    // MARK: - Properties
    let productId: String
    let productName: String
    let shortDescription: String
    let longDescription: String
    let price: String
    let productImage: String
    let reviewRating: Double
    let reviewCount: Int
    let inStock: Bool
    
    // MARK: - CodingKeys
    private enum CodingKeys: CodingKey {
        case productId, productName, shortDescription, longDescription, price, productImage, reviewRating, reviewCount, inStock
    }
    
    // MARK: - Decoding Safely
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.productId = try values.decodeIfPresent(String.self, forKey: .productId) ?? "Product ID not available"
        self.productName = try values.decodeIfPresent(String.self, forKey: .productName) ?? "Product Name not available"
        self.shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription) ?? "Short description not available"
        self.longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription) ?? "Long description not available"
        self.price = try values.decodeIfPresent(String.self, forKey: .price) ?? "Price nos available"
        self.productImage = try values.decodeIfPresent(String.self, forKey: .productImage) ?? "Product image nos available"
        self.reviewRating = try values.decodeIfPresent(Double.self, forKey: .reviewRating) ?? 0.0
        self.reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
        self.inStock = try values.decodeIfPresent(Bool.self, forKey: .inStock) ?? false
    }
    
    
}
