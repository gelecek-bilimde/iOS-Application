//
//  SettingTableViewCell.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 16.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSetting(name: String, image: UIImage){
        settingImageView.image = image
        settingNameLabel.text = name
    }
}
