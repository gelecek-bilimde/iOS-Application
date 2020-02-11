//
//  OnboardingViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 11.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseDatabase

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAnimationView()
        checkIsAuthenticate()
    }
    
    func setAnimationView(){
        let animationView = AnimationView(name: "invites-sent")
        animationView.frame = self.view.frame
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.loopMode = .loop
        
        animationView.play()
    }

    func checkIsAuthenticate(){
        if Auth.auth().currentUser != nil {
            getUserData()
        } else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ){
                self.performSegue(withIdentifier: "goToLoginPage", sender: nil)
            }
        }
    }
    func getUserData(){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(currentUserUid).observe(.value) { (snapshot) in
            guard let userDic = snapshot.value as? NSDictionary else { return }
            guard let displayName = userDic["displayName"] as? String else { return }
            guard let email = userDic["email"] as? String else { return }
            guard let photoURL = userDic["photoURL"] as? String else { return }
            CurrentUser.addCurrentUser(name: displayName, photoURL: photoURL, email: email)
            self.performSegue(withIdentifier: "goToApp", sender: nil)
        }
    }
    
}
