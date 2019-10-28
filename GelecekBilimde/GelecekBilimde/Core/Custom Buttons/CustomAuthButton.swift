//
//  CustomButton.swift
//  Randomly
//
//  Created by Alperen Ünal on 3.06.2019.
//  Copyright © 2019 Alperen Ünal. All rights reserved.
//

import UIKit

class CustomAuthButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        setShadow()
        setTitleColor(UIColor.tableViewBgColor, for: .normal)
        backgroundColor = UIColor.white
        titleLabel?.font = UIFont.sfTextFont
        layer.cornerRadius = 15
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
}
