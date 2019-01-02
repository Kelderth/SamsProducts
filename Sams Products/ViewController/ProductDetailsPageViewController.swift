//
//  ProductDetailsPageViewController.swift
//  Sams Products
//
//  Created by Kevin Yu on 1/2/19.
//  Copyright © 2019 Kelderth. All rights reserved.
//

import UIKit

class ProductDetailsPageViewController: UIPageViewController {

    weak var dataSourceDelegate: ProductDetailsPageViewDataSource!
    weak var callbackDelegate: ProductDetailsPageViewCallbackDelegate!
    
    var currentIndex: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
    }
    
    func setup(_ sender: ProductDetailsPageViewDataSource & ProductDetailsPageViewCallbackDelegate) {
        self.dataSourceDelegate = sender
        self.callbackDelegate = sender
        
        let vc = self.dataSourceDelegate.viewControllerFor(currentIndex)
        
        self.setViewControllers([vc],
                                direction: .forward,
                                animated: false,
                                completion: nil)
    }

}

extension ProductDetailsPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.dataSourceDelegate?.previousVC(viewController.view.tag)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.dataSourceDelegate?.nextVC(viewController.view.tag)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first else { return }
        self.callbackDelegate.willTransitionTo(vc.view.tag)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            self.callbackDelegate?.didTransition()
        }
    }
}

