//
//  MasterViewController.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

class CollectionListVC: UITableViewController {

    let viewModel = CollectionViewModel()
    var detailViewController: CollectionDetailVC? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CollectionDetailVC
        }
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        refresh()
    }

    @objc
    func refresh() {
        viewModel.refreshData { error in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .default) {_ in
                        self.tableView.refreshControl?.endRefreshing()
                    }
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                    self.navigationItem.prompt = "Pull table to reload"
                } else {
                    self.navigationItem.prompt = nil
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let collection = viewModel[indexPath.row] {
                let controller = (segue.destination as! UINavigationController).topViewController as! CollectionDetailVC
                controller.loadProducts(ofCollection: collection)
                controller.navigationItem.title = collection.title
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let collection = viewModel[indexPath.row]
        cell.textLabel!.text = collection?.title ?? "Empty"
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor(red: 92.0 / 255.0, green: 106.0 / 255.0, blue: 196.0 / 255.0, alpha: 0.85)
        cell.selectedBackgroundView = selectedBackground
        return cell
    }
}

