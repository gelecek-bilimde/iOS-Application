//
//  GoogleSignInAuth.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 11.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseDatabase

class GoogleSignInAuth: NSObject, GIDSignInDelegate {
    
    var currentVC: UIViewController = UIViewController()
    
    init(vc: UIViewController) {
        super.init()
        self.currentVC = vc
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
  @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let hud = CustomProgressHUD()
        hud.play(view: currentVC.view)
        
        if let err = error {
            hud.stop()
            print("Error about sign in with google Error:\(err)")
            return
        }
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { [weak self] (authUser, error) in
            guard let self = self else { return }
            if let err = error {
                hud.stop()
                print("Error about sign in with google Error:\(err)")
                return
            }
            else {
                hud.stop()
                guard let userResult = authUser?.user else { return }
                self.writeUserToDB(user: userResult)
            }
        }
    }

    func authenticationWithGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }

    func writeUserToDB(user: User) {
        let displayName = user.displayName ?? ""
        let photoUrl = user.photoURL?.absoluteString ?? ""
        let email = user.email ?? ""
        let userDic: [String:Any] = ["displayName": displayName, "email": email, "photoURL": photoUrl, "providerID": user.providerID]
        Database.database().reference().child("Users").child(user.uid).setValue(userDic)
        CurrentUser.addCurrentUser(name: displayName, photoURL: photoUrl, email: email)
        currentVC.performSegue(withIdentifier: UnwindIdentifier.identifier(for: .InitialPage), sender: nil)
    }
}
