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

    // MARK: - Outlets - Data
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    // MARK: - Outlets - Navigation
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentIndexLabel: UILabel!
    @IBOutlet weak var ofLabel: UILabel!
    @IBOutlet weak var totalIndexLabel: UILabel!
    // MARK: - Outlets - Containers
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productContentView: UIView!
    @IBOutlet weak var detailsStackView: UIStackView!
    // MARK: - Outlets - Constraints
    @IBOutlet weak var productDetailsHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Product selected from the ProductListViewController.
        guard let productDetails = product else { return }
        setupView(productDetails: productDetails)
        
        // Previous Button is disabled if the first product is being displayed.
        if productIndex == 0 {
            previousButton.isEnabled = false
        }
        
        // Product detail content height.
        productDetailsHeight.constant = detailsStackView.frame.maxY + view.frame.height
        
        // Index Navigation Initialization.
        indexNavigationUpdate()
    }
    
    // MARK: - Functions
    /**
     Method that saves the product details within the view labels and return them to the UI.
     - Parameters:
        - productDetails: variable of Product type which refers to a produc item from the product source array.
     */
    func setupView(productDetails: Product){
        productNameLabel.text = productDetails.productName
        longDescriptionLabel.text = productDetails.longDescription.htmlToString
        shortDescriptionLabel.text = productDetails.shortDescription.htmlToString
        productIdLabel.text = "SKU: "+productDetails.productId
        ratingLabel.text = "Rating: \(String(format: "%.1f", productDetails.reviewRating))"
        reviewCountLabel.text = "Review Count: \(productDetails.reviewCount)"
        inStockLabel.text = productDetails.inStock ? "In Stock" : "Not Available"
        inStockLabel.textColor = productDetails.inStock ? UIColor.blue : UIColor.red
        priceLabel.text = productDetails.price
        
        let imageURLString = NetworkService.urlApiCall + productDetails.productImage
        
        showImage.getImage(imageURLString: imageURLString, completion: { productImage in
            self.productImageView.image = productImage
        })
    }
    
    /// Index Navigation
    func indexNavigationUpdate() {
        currentIndexLabel.text = productIndex == 0 ? "1" : "\(productIndex + 1)"
        totalIndexLabel.text = "\(productSource.count)"
    }
    
    // MARK: - Actions
    // When NEXT button is tapped.
    @IBAction func nextProduct(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
        if productIndex >= productSource.count - 1 {
            nextButton.isEnabled = false
            return
        }
        
        previousButton.isEnabled = true
        productIndex += 1
            
        let itemSource = productSource[productIndex]
            
        setupView(productDetails: itemSource)
        
        indexNavigationUpdate()
    }
    // When PREVIOUS button is tapped.
    @IBAction func previousProduct(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)

        nextButton.isEnabled = true
        
        productIndex -= 1
        
        let itemSource = productSource[productIndex]
        
        setupView(productDetails: itemSource)
        
        if productIndex == 0 {
            previousButton.isEnabled = false
            indexNavigationUpdate()
            return
        }
        indexNavigationUpdate()
    }
    
    
}
