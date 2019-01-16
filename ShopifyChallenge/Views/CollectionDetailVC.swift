//
//  DetailViewController.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

class CollectionDetailVC: UITableViewController {

    let viewModel = CollectionDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel[indexPath.row]?.title ?? "Empty"
        return cell
    }

    func loadProducts(ofCollection collection: CustomCollection) {
        viewModel.loadProducts(ofCollection: collection) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

