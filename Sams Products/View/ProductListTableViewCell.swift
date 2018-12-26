//
//  ProductListTableViewCell.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    // MARK: - Functions
    func setup(product: Product) {
        self.nameLabel.text = product.productName
        self.ratingLabel.text = "Rating: \(String(format: "%.1f", product.reviewRating))"
        self.inStockLabel.text = product.inStock ? "In stock" : "Not available"
        self.priceLabel.text = product.price
        
        let imageURLString = NetworkService.shared.urlApiCall + product.productImage
        
        if let image = ImageCache.shared.getAssetImageFromCache(identifier: imageURLString) {
            self.productImageView.image = image
        } else {
            do {
                if let imageURL = URL(string: imageURLString) {
                    let imageData = try Data(contentsOf: imageURL)
                    
                    if let image = UIImage(data: imageData) {
                        ImageCache.shared.saveAssetImageToCache(identifier: imageURLString, image: image)
                        DispatchQueue.main.async {
                            self.productImageView.image = image
                        }
                    }
                }
            } catch let error {
                print("Error fetching image - \(error.localizedDescription)")
                NSLog("Error fetching image - \(error.localizedDescription)")
            }
        }
    }

    override func prepareForReuse() {
        self.productImageView.image = nil
        super.prepareForReuse()
    }
    
    

}
