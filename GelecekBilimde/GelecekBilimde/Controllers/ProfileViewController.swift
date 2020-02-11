//
//  ProfileViewController.swift
//  GelecekBilimde
//
//  Created by Burak Furkan Asilturk on 30.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import KeychainSwift

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        //Set login view controller to root VC
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = Destination().Login
        //Go Login Page
        performSegue(withIdentifier: "goToAuth", sender: nil)
    }
}


// MARK: - Actions
extension ProfileViewController {
    
}


// MARK: - Auxiliary Methods
extension ProfileViewController {
    
}


// MARK: - Delegates
extension ProfileViewController {
    
}
