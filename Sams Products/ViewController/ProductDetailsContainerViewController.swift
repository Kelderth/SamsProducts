//
//  ProductDetailsPageViewController.swift
//  Sams Products
//
//  Created by Kevin Yu on 1/2/19.
//  Copyright © 2019 Kelderth. All rights reserved.
//

import UIKit

class ProductDetailsContainerViewController: UIViewController {

    // MARK: - Properties
    var productSource: [Product] = [Product]()
    var productIndex: Int = 0 {
        didSet {
            self.currentIndexLabel?.text = String(productIndex + 1)
        }
    }
    
    // MARK: - Outlets - Display
    @IBOutlet weak var displayView: ProductDetailsPageViewController!
    
    // MARK: - Outlets - Navigation
    @IBOutlet weak var currentIndexLabel: UILabel!
    @IBOutlet weak var ofLabel: UILabel!
    @IBOutlet weak var totalIndexLabel: UILabel!
    
    private var pendingIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var pageView = self.children.first(where: { $0 is ProductDetailsPageViewController }) as? ProductDetailsPageViewController
        pageView?.currentIndex = productIndex
        pageView?.setup(self)
        
        // set up navigation display
        self.currentIndexLabel.text = String(productIndex + 1)
        self.totalIndexLabel.text = String(productSource.count)
    }
}
extension ProductDetailsContainerViewController: ProductDetailsPageViewDataSource, ProductDetailsPageViewCallbackDelegate {
    
    func viewControllerFor(_ index: Int) -> UIViewController {
        let vcIdentifier = "ProductDetails"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as! ProductDetailsViewController
        vc.view.tag = index
        vc.product = self.productSource[index]
        
        return vc
    }
    
    func previousVC(_ index: Int) -> UIViewController? {
        if (index == 0) { return nil }
        
        return self.viewControllerFor(index - 1)
    }
    
    func nextVC(_ index: Int) -> UIViewController? {
        if (index == self.productSource.count - 1) { return nil }
        
        return self.viewControllerFor(index + 1)
    }
    
    func willTransitionTo(_ index: Int) {
        self.pendingIndex = index
    }
    func didTransition() {
        self.productIndex = self.pendingIndex
    }
}
