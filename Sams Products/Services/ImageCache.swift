//
//  ImageCache.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ImageCache {
    
    private let assetCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCache()
        
    private init() {}
    
    func saveAssetImageToCache(identifier: String, image: UIImage) {
        assetCache.setObject(image, forKey: identifier as NSString)
    }
    
    func getAssetImageFromCache(identifier: String) -> UIImage? {
        return assetCache.object(forKey: identifier as NSString)
    }
    
    
}
