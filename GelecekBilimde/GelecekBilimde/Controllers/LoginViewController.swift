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
    
    private let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIsAuthenticate()
    }
    
}
// MARK: - Actions
extension LoginViewController {
    @IBAction func authButtonClicked(_ sender: CustomAuthButton) {
        //Call authenticate function from Authentication class
        Authentication.sharedInstance.authenticate { (result) in
            //Take result and control with switch case
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                DispatchQueue.main.async {
                    //Set user credentials with keychain
                    self.keychain.set(user.accessToken, forKey: "CurrentUserToken")
                    self.keychain.set(user.name, forKey: "CurrentUserName")
                    self.keychain.set(user.email, forKey: "CurrentUserEmail")
                    self.keychain.set(true, forKey: "isAuthenticate")
                    //Go to Initial Page
                    self.performSegue(withIdentifier: "goToInitialPage", sender: nil)
                }
            }
        }
    }
}

// MARK: - Auxiliary Methods
extension LoginViewController {
    func checkIsAuthenticate(){
        //Get is Authentice data from keychain
        guard let isAuthenticate = keychain.getBool("isAuthenticate") else { return }
        
        if isAuthenticate {
            //Set Current User and Go to Initial Page
            guard let currentUserToken = keychain.get("CurrentUserToken") else { return }
            guard let currentUserName = keychain.get("CurrentUserName") else { return }
            guard let currentUserEmail = keychain.get("CurrentUserEmail") else { return }
            
            CurrentUser.addCurrentUser(accessToken: currentUserToken, name: currentUserName, email: currentUserEmail)
            
            performSegue(withIdentifier: "goToInitialPage", sender: nil)
        }
    }
}

