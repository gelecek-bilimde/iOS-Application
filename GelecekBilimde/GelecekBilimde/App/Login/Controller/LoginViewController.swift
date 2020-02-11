//
//  LoginViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var horizontalView: UIView!
    
    let googleButton = GIDSignInButton()
    var googleAuth: GoogleSignInAuth!

    override func viewDidLoad() {
        super.viewDidLoad()
        googleAuth = GoogleSignInAuth(vc: self)
        setupGoogleButton()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    
}
// MARK: - Actions
extension LoginViewController {
    func googleButtonTapped(_ sender: Any){
        googleAuth.authenticationWithGoogleSignIn()
    }
}

// MARK: - Auxiliary Methods
extension LoginViewController {
    func setupGoogleButton(){
        //Add Google Sign In Button
        
        view.addSubview(googleButton)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            googleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            googleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            googleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            googleButton.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 30)
        ])
       
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
}

