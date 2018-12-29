//
//  ProductListTableViewCell.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let showImage = ImageDownloader()

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
        self.inStockLabel.textColor = product.inStock ? UIColor.blue : UIColor.red
        self.priceLabel.text = product.price
        
        let imageURLString = NetworkService.urlApiCall + product.productImage
        
        showImage.getImage(imageURLString: imageURLString, completion: { productImage in
            self.productImageView.image = productImage
        })
    }
    

}
