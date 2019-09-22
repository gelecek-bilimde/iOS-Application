//
//  VideoTableViewCell.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    
    @IBOutlet weak var videoDateLabel: UILabel!
    
    
    @IBOutlet weak var videoBookmarkImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
