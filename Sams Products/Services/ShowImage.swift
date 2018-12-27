//
//  ShowImage.swift
//  Sams Products
//
//  Created by MCS on 12/26/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ShowImage {
    
    var imageReturned: UIImage?
    
    func getImage(imageURLString: String) -> UIImage? {
        if let image = ImageCache.shared.getAssetImageFromCache(identifier: imageURLString) {
            self.imageReturned = image
            return imageReturned!
        } else {
            do {
                if let imageURL = URL(string: imageURLString) {
                    let imageData = try Data(contentsOf: imageURL)
                    
                    if let image = UIImage(data: imageData) {
                        ImageCache.shared.saveAssetImageToCache(identifier: imageURLString, image: image)
                        DispatchQueue.main.async {
                            self.imageReturned = image
                        }
                    }
                }
            } catch let error {
                print("Error fetching image - \(error.localizedDescription)")
                NSLog("Error fetching image - \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    
}
