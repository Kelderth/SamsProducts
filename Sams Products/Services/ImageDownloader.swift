//
//  ShowImage.swift
//  Sams Products
//
//  Created by MCS on 12/26/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    var imageReturned: UIImage?
    
    /**
     Method that saves or loads images from the cache.
     - Parameters:
        - imageURLString: The image URL
        - completion: Closure that returns an UIImage instance to use after in the main thread
     */
    
    func getImage(imageURLString: String, completion: @escaping (UIImage)->()) {
        if let image = ImageCache.shared.getAssetImageFromCache(identifier: imageURLString) {
            completion(image)
        } else {
            if let imageURL = URL(string: imageURLString) {
                URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                    guard let data = data else { return }
                        
                    if let image = UIImage(data: data) {
                            ImageCache.shared.saveAssetImageToCache(identifier: imageURLString, image: image)
                            
                            DispatchQueue.main.async {
                                completion(image)
                            }
                    }
                }).resume()
            }
        }
    }
    
    
}
