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
        
        Auth.auth().signIn(with: credential) { (authUser, error) in
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
        let appUser = AppUser(name: user.displayName!, photoURL: user.photoURL!.absoluteString, email: user.email!)
        let userDic: [String:Any] = ["displayName": user.displayName!, "email": user.email!, "photoURL": user.photoURL!.absoluteString, "providerID": user.providerID]
        Database.database().reference().child("Users").child(user.uid).setValue(userDic)
        CurrentUser.addCurrentUser(name: appUser.name, photoURL: appUser.photoURL, email: appUser.email)
        self.currentVC.performSegue(withIdentifier: "goToInitialPage", sender: nil)
    }
}
