//
//  ArticleCategoryCell.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 6.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class ArticleCategoryCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .barTintColor : .clear
            nameLabel.textColor = isSelected ? .white : .darkGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configure(with category: ArticleCategory) {
        nameLabel.text = category.category.description
    }
}
