//
//  LoginViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var horizontalView: UIView!
    
    let googleButton = GIDSignInButton()
    var googleAuth: GoogleSignInAuth!
    var signInWithAppleAuth: SignInWithAppleAuth!

    override func viewDidLoad() {
        super.viewDidLoad()
        googleAuth = GoogleSignInAuth(vc: self)
        signInWithAppleAuth = SignInWithAppleAuth(vc: self)
        setupGoogleButton()
        appleLoginButton()
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
    @available(iOS 13, *)
    @objc func signInWithAppleButtonTapped() {
        signInWithAppleAuth.startSignInWithAppleFlow()
    }
}

// MARK: - Auxiliary Methods
extension LoginViewController {
    
    func appleLoginButton() {
        if #available(iOS 13.0, *) {
            let appleLoginBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
            appleLoginBtn.addTarget(self, action: #selector(signInWithAppleButtonTapped), for: .touchUpInside)
            self.view.addSubview(appleLoginBtn)
            // Setup Layout Constraints to be in the center of the screen
            appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                appleLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                appleLoginBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
                appleLoginBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
                appleLoginBtn.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
                appleLoginBtn.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
        }
    }
    
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

