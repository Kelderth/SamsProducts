//
//  ImageCache.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ImageCache {
    
    // MARK: - Properties
    // Instance of the mutable and temporary cache that stores Key(NSString)-Values(UIImage).
    private let assetCache = NSCache<NSString, UIImage>()
    
    // MARK: - Singleton
    static let shared = ImageCache()

    // MARK: - Functions
    private init() {}
    
    /**
     Saves an image into the cache<Key:Value> to used it later.
     - Parameters:
        - identifier: STRING variable that hold an URL as the Key
        - image: UIIMAGE variable that holds an image as the Value
    */
    func saveAssetImageToCache(identifier: String, image: UIImage) {
        assetCache.setObject(image, forKey: identifier as NSString)
    }
    
    /**
     Loads an image from the cache from its identifier
     - Parameters:
        - identifier: STRING variable that hold the URL (Key) of the Image
     - Returns: An UIImage object as an optional because it can be nil.
     */
    func getAssetImageFromCache(identifier: String) -> UIImage? {
        return assetCache.object(forKey: identifier as NSString)
    }
    
    
}
