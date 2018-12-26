//
//  ProductContainer.swift
//  Sams Products
//
//  Created by MCS on 12/24/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import Foundation

struct ProductContainer: Decodable {
    
    // MARK: - Properties
    var products: [Product]?
    var totalProducts: Int
    var pageNumber: Int
    var pageSize: Int
    var statusCode: Int
    
    private enum CodingKeys: CodingKey {
        case products, totalProducts, pageNumber, pageSize, statusCode
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.products = try values.decodeIfPresent([Product].self, forKey: .products) ?? nil
        self.totalProducts = try values.decodeIfPresent(Int.self, forKey: .totalProducts) ?? 0
        self.pageNumber = try values.decodeIfPresent(Int.self, forKey: .pageNumber) ?? 0
        self.pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize) ?? 0
        self.statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
    }
    
}
