//
//  DetailViewController.swift
//  ShopifyChallenge
//
//  Created by Phuoc Tran on 2019-01-14.
//  Copyright © 2019 Phuoc Tran. All rights reserved.
//

import UIKit

class CollectionDetailVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    var detailItem: [Product]?

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItem?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard detailItem != nil else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Empty"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = detailItem![indexPath.row].title
        return cell
    }

}

