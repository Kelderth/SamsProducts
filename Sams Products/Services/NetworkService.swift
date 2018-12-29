//
//  NetworkService.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import Foundation

class NetworkService {
    
    // MARK: - Properties
    var products: ProductContainer?

    // MARK: - Singleton
    static let shared = NetworkService()
    
    // MARK: - Parameters expected for WalmartLabs Test
    static let urlApiCall: String = "https://mobile-tha-server.firebaseapp.com"
    private let session = URLSession.shared
    
    // MARK: - Methods
    /**
     Downloads data from Walmart's API and Parse the JSON that will feed our application.
     - Parameters:
        - pageNumber: product page number of Wallmart's API
        - pageSize: number of products that will be retrieved by intent
        - completion: Closure that escapes an optional ProductContainer instance and will be manipulated after the method finishes its tasks
    */
    func fetchData(pageNumber: Int, pageSize: Int, completion: @escaping (ProductContainer?)->()) {

        // Rule of no more than 30 items per page.
        let pageSize =  pageSize > 30 ? 30 : pageSize
        
        // Walmart's URL product list.
        let urlEndPoint = NetworkService.urlApiCall + "/walmartproducts/\(pageNumber)/\(pageSize)"
        
        // unwraping the URL.
        guard let validURL = URL(string: urlEndPoint) else { return }

        // Downloading Walmart's JSON
        session.dataTask(with: validURL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                guard let data = data else { return }
                
                // Due to it can throw an error, we should handle the data within a DO - CATCH statement.
                do {
                    // JSON Decoding
                    let productData = try JSONDecoder().decode(ProductContainer.self, from: data)
                    // completion acts like a return.
                    completion(productData)
                } catch let jsonError {
                    print(jsonError)
                    completion(nil)
                }
            }
        }.resume() // Resume the session.dataTask
    }
    

}
