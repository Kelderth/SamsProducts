//
//  ProductDetailsPageViewDelegate.swift
//  Sams Products
//
//  Created by Kevin Yu on 1/2/19.
//  Copyright © 2019 Kelderth. All rights reserved.
//

import UIKit

protocol ProductDetailsPageViewDataSource: class {
    func viewControllerFor(_ index: Int) -> UIViewController
    func previousVC(_ index: Int) -> UIViewController?
    func nextVC(_ index: Int) -> UIViewController?
}

protocol ProductDetailsPageViewCallbackDelegate: class {
    func willTransitionTo(_ index: Int)
    func didTransition()
}
