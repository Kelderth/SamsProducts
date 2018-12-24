//
//  ProductListViewController.swift
//  Sams Products
//
//  Created by MCS on 12/24/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }


}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else { return UITableViewCell() }
        
        return cell
    }
    
    
}
