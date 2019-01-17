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
    var loadingView = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidesWhenStopped = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = viewModel[indexPath.row] else {
                return createEmptyCell(tableView)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.configure(for: product, in: tableView, at: indexPath)
        return cell
    }

    private func createEmptyCell(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")
        cell!.textLabel?.text = "Empty"
        return cell!
    }

    func loadProducts(ofCollection collection: CustomCollection) {
        loadingView.startAnimating()
        viewModel.loadProducts(ofCollection: collection) { error in
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
                    self.loadingView.stopAnimating()
                }
            }
        }
    }

}

