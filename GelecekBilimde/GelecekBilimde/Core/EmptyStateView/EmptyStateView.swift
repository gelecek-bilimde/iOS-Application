//
//  EmptyStateView.swift
//  GelecekBilimde
//
//  Created by Barış Uyar on 23.06.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class EmptyStateView: UIView {
    
    // We can create a view to show message when there is no item to show user.
    private var messageLabel: UILabel!
    private var message: String = ""
    
    public init(frame: CGRect, message: String) {
        super.init(frame: frame)
        self.message = message
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = .boldSystemFont(ofSize: 18)
        messageLabel.textColor = .white
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

