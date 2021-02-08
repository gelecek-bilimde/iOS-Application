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

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var horizontalView: UIView!
    
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
}
// MARK: - Actions
extension LoginViewController {
    private func googleButtonTapped(_ sender: Any) {
        googleAuth.authenticationWithGoogleSignIn()
    }
    
    @available(iOS 13, *)
    @objc private func signInWithAppleButtonTapped() {
        signInWithAppleAuth.startSignInWithAppleFlow()
    }
}

// MARK: - Auxiliary Methods
extension LoginViewController {
    
    private func setupGoogleButton() {
        googleButton.colorScheme = .dark
        googleButton.backgroundColor = .init(red: 65 / 255, green: 133 / 255, blue: 244 / 255, alpha: 1)
        googleButton.layer.cornerRadius = 5
        view.addSubview(googleButton)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.widthAnchor.constraint(equalToConstant: 200),
            googleButton.heightAnchor.constraint(equalToConstant: 55),
            googleButton.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 30)
        ])
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    private func appleLoginButton() {
        if #available(iOS 13.0, *) {
            let appleLoginBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
            appleLoginBtn.addTarget(self, action: #selector(signInWithAppleButtonTapped), for: .touchUpInside)
            view.addSubview(appleLoginBtn)
            appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                appleLoginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                appleLoginBtn.widthAnchor.constraint(equalToConstant: 200),
                appleLoginBtn.heightAnchor.constraint(equalToConstant: 50),
                appleLoginBtn.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20)
            ])
        }
    }
}

