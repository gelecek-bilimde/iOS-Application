//
//  SettingTableViewCell.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 16.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingNameLabel: UILabel!
    
    func setSetting(name: String, image: UIImage) {
        settingImageView.image = image.withRenderingMode(.alwaysTemplate)
        settingImageView.tintColor = .darkGray
        settingNameLabel.text = name
    }
}
