//
//  ProductListViewController.swift
//  Sams Products
//
//  Created by MCS on 12/24/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: - Properties
    var productPage: Int {
        return productSource.count / 10
    }

    var productSource: [Product] = [Product]()
    var totalProducts: Int = 0

    // MARK: - Outlets
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
        updateView()
        
    }
    
    //MARK: - Functions
    
    func updateView() {
        
        NetworkService.shared.fetchData(pageNumber: self.productPage + 1, pageSize: 10, completion: { productContainer in
            
            guard let productContainer = productContainer else { return }
            
            self.totalProducts = productContainer.totalProducts
            
            if let products = productContainer.products {
                
                if self.productPage >= 1 {
                    self.productSource.append(contentsOf: products)
                } else {
                    self.productSource = products
                }
                
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            }
        })
    }


}

// MARK: - Extensions

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductListTableViewCell else { return UITableViewCell() }
        
        let item = productSource[indexPath.row]
        cell.setup(product: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == productSource.count - 1 && productSource.count % 10 == 0 && productSource.count < totalProducts {

            updateView()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcIdentifier = "ProductDetails"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let destination = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? ProductDetailsViewController else { return }
        
        guard let productSelected = tableView.indexPathForSelectedRow?.row else { return }
        
        destination.product = productSource[productSelected]
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
