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
    let showImage = ImageDownloader()
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
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productContentView: UIView!
    @IBOutlet weak var productDetailsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var detailsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if productIndex == 0 {
            previousButton.isEnabled = false
        }
        

        var contentHeight = (priceLabel.frame.origin.y - view.frame.height)
        contentHeight = contentHeight * -1
        
        productDetailsHeight.constant = contentHeight + detailsStackView.frame.maxY
        

    }
    
    // MARK: - Functions
    func setupView() {
        
        guard let productDetails = product else { return }
        
        feedLabel(productDetails: productDetails)
    }
    
    func feedLabel(productDetails: Product){
        
        productNameLabel.text = productDetails.productName
        longDescriptionLabel.text = productDetails.longDescription.htmlToString
        shortDescriptionLabel.text = productDetails.shortDescription.htmlToString
        productIdLabel.text = "SKU: "+productDetails.productId
        ratingLabel.text = "Rating: \(String(format: "%.1f", productDetails.reviewRating))"
        reviewCountLabel.text = "Review Count: \(productDetails.reviewCount)"
        inStockLabel.text = productDetails.inStock ? "In Stock" : "Not Available"
        priceLabel.text = productDetails.price
        
        let imageURLString = NetworkService.shared.urlApiCall + productDetails.productImage
        
        showImage.getImage(imageURLString: imageURLString, completion: { productImage in
            self.productImageView.image = productImage
        })
    }
    
    @IBAction func nextProduct(_ sender: UIButton) {
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
        if productIndex >= productSource.count - 1 {
            nextButton.isEnabled = false
            return
        }
        
        previousButton.isEnabled = true
        productIndex += 1
            
        let itemSource = productSource[productIndex]
            
        feedLabel(productDetails: itemSource)
    }
    
    @IBAction func previousProduct(_ sender: UIButton) {
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)

        nextButton.isEnabled = true
        
        productIndex -= 1
        
        let itemSource = productSource[productIndex]
        
        feedLabel(productDetails: itemSource)
        
        if productIndex == 0 {
            previousButton.isEnabled = false
            return
        }

    }
    
    
}
