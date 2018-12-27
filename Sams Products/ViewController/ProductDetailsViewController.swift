//
//  ProductDetailsViewController.swift
//  Sams Products
//
//  Created by MCS on 12/24/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var product: Product?
    var productIndex: Int = 0
    let showImage = ShowImage()
    var productSource: [Product] = [Product]()

    
    // MARK: - Outlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        print("Quantity of Products: ", productSource.count)
    }
    
    // MARK: - Functions
    
    func setupView() {
        
        guard let productDetails = product else { return }
        
        productNameLabel.text = productDetails.productName
        longDescriptionLabel.text = productDetails.longDescription.htmlToString
        shortDescriptionLabel.text = productDetails.shortDescription.htmlToString
        productIdLabel.text = "SKU: "+productDetails.productId
        ratingLabel.text = "Rating: \(String(format: "%.1f", productDetails.reviewRating))"
        reviewCountLabel.text = "Review Count: \(productDetails.reviewCount)"
        inStockLabel.text = productDetails.inStock ? "In Stock" : "Not Available"
        priceLabel.text = productDetails.price
        
        let imageURLString = NetworkService.shared.urlApiCall + productDetails.productImage

        productImageView.image = showImage.getImage(imageURLString: imageURLString)
    }
    
    
    @IBAction func nextProduct(_ sender: UIButton) {
        
        productIndex += 1
        
        let example = productSource[productIndex].productName
        productNameLabel.text = example
        
//        let alert = UIAlertController(title: "Products Navigation", message: "Would you like to continue?", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Next Product Index: \(productIndex)", style: .default, handler: nil)
//        alert.addAction(alertAction)
//        self.present(alert, animated: true)
        
    }
    
    @IBAction func previousProduct(_ sender: UIButton) {
        
        productIndex -= 1
        
//        let alert = UIAlertController(title: "Product Navigation", message: "Would you like to continue?", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Previous Product Index: \(productIndex)", style: .default, handler: nil)
//        alert.addAction(alertAction)
//        self.present(alert, animated: true)
    }
    
    
}
