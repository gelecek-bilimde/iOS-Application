//
//  CustomProgressHUD.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 11.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import JGProgressHUD

struct CustomProgressHUD {
    var progressHUD: JGProgressHUD
    
    init() {
        self.progressHUD = JGProgressHUD(style: .dark)
        self.progressHUD.textLabel.text = "Yükleniyor"
    }
    
    func play(view: UIView) {
        self.progressHUD.show(in: view)
    }
    
    func stop() {
        self.progressHUD.dismiss(animated: true)
    }
}
