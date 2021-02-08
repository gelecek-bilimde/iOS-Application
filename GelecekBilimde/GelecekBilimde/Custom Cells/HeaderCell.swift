//
//  HeaderCell.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 8.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class HeaderCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    func set(name: String) {
        nameLabel.text = name
    }
}
