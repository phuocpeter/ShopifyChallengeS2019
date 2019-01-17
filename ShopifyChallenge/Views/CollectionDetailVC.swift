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
    var isFetching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isFetching,
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell,
            let product = viewModel[indexPath.row] else {
                print("")
                return createEmptyCell(tableView)
        }
        cell.configure(for: product, in: tableView, at: indexPath)
        return cell
    }

    func createEmptyCell(_ tableView: UITableView) -> UITableViewCell {
        print("Empty creatign")
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")
        cell!.textLabel?.text = "Empty"
        return cell!
    }

    func loadProducts(ofCollection collection: CustomCollection) {
        isFetching = true
        viewModel.loadProducts(ofCollection: collection) { error in
            self.isFetching = false
            DispatchQueue.main.async {
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Back", style: .default) {_ in
                        // Pop back to master
                        if let navController = self.splitViewController?.viewControllers[0] as? UINavigationController {
                            navController.popViewController(animated: true)
                        }
                    }
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

