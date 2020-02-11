//
//  VideosTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class VideosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
    }
}


// MARK: - Table view data source
extension VideosTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
