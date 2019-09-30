//
//  BookmarkedVideosTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class BookmarkedVideosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
