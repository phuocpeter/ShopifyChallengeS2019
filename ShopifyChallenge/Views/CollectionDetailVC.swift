//
//  DetailViewController.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

/// Secondary View Controller
class CollectionDetailVC: UITableViewController {

    /// View Model.
    let viewModel = CollectionDetailViewModel()

    /// Loading Indicator
    private var loadingView = UIActivityIndicatorView(style: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidesWhenStopped = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingView)
    }

    // MARK: - Table View Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isLoaded ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Products" : nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoaded {
            return section == 0 ? 1 : viewModel.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 600 : 124
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.isLoaded else {
            let cellText = viewModel.isFetching ? "Loading" : "Please choose a category"
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            cell.textLabel?.text = cellText
            return cell
        }

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionTableViewCell
            if let collection = viewModel.collection {
                cell.configure(for: collection)
            }
            return cell
        }

        guard let product = viewModel[indexPath.row] else {
                return createEmptyCell(tableView)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.configure(for: product)
        return cell
    }

    /// Creates an empty cell when no products are loaded.
    ///
    /// - Parameter tableView: table view.
    /// - Returns: an cell representing empty table.
    private func createEmptyCell(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")
        cell!.textLabel?.text = "Loading"
        return cell!
    }

    /// Initiate the loading product process.
    ///
    /// - Parameter collection: the collection of these products.
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

