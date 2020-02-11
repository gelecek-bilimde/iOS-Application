//
//  LoginViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import KRProgressHUD
import KeychainSwift

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
// MARK: - Actions
extension LoginViewController {
    
}

// MARK: - Auxiliary Methods
extension LoginViewController {
//    func checkIsAuthenticate(){
//        //Get is Authentice data from keychain
//        guard let isAuthenticate = keychain.getBool("isAuthenticate") else { return }
//
//        if isAuthenticate {
//            //Set Current User and Go to Initial Page
//            guard let currentUserToken = keychain.get("CurrentUserToken") else { return }
//            guard let currentUserName = keychain.get("CurrentUserName") else { return }
//            guard let currentUserEmail = keychain.get("CurrentUserEmail") else { return }
//
//            CurrentUser.addCurrentUser(accessToken: currentUserToken, name: currentUserName, email: currentUserEmail)
//
//            performSegue(withIdentifier: "goToInitialPage", sender: nil)
//        }
//    }
}

