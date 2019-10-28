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
    
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        //Call authentication logout function
        Authentication.sharedInstance.logout()
        //Clear current user data
        CurrentUser.clearCurrentUser()
        //Remove user credentials from keychain
        keychain.delete("CurrentUserToken")
        keychain.delete("CurrentUserName")
        keychain.delete("CurrentUserEmail")
        //Set isAuthenticate to false
        self.keychain.set(false, forKey: "isAuthenticate")
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
