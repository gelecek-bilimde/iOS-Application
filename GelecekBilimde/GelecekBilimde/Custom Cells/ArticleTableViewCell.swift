//
//  ArticleTableViewCell.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var articleMainImageView: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    @IBOutlet weak var articleAddedDateLabel: UILabel!
    
    @IBOutlet weak var articleBookmarkImageView: UIImageView!
    

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
