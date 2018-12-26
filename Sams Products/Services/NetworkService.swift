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
    let urlApiCall: String = "https://mobile-tha-server.firebaseapp.com"
    private let session = URLSession.shared
    
    /**
     fetchData is in charge of downloading the data that will feed our application.
     
    */
    func fetchData(pageNumber: Int, pageSize: Int, completion: @escaping (ProductContainer?)->()) {

        let pageSize =  pageSize > 30 ? 30 : pageSize
        
        let urlEndPoint = urlApiCall + "/walmartproducts/\(pageNumber)/\(pageSize)"
        
        guard let validURL = URL(string: urlEndPoint) else { return }

        session.dataTask(with: validURL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                guard let data = data else { return }
                
                do {
                    // JSON Decoding
                    let productData = try JSONDecoder().decode(ProductContainer.self, from: data)
                    completion(productData)
                } catch let jsonError {
                    print(jsonError)
                    completion(nil)
                }
            }
        }.resume()
        
    }
    

}
