//
//  ProfileViewController.swift
//  GelecekBilimde
//
//  Created by Burak Furkan Asilturk on 30.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CurrentUser.currentUser)
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        try? Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        CurrentUser.clearCurrentUser()
        dismiss(animated: true)
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
