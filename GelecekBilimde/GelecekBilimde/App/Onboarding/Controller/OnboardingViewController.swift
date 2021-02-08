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

final class OnboardingViewController: UIViewController {

    private var animationView: AnimationView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAnimationView()
        checkIsAuthenticate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationView.stop()
        animationView.removeFromSuperview()
    }
    
    private func setAnimationView() {
        animationView = AnimationView(name: "invites-sent")
        animationView.frame = view.frame
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.loopMode = .loop
        
        animationView.play()
    }

    private func checkIsAuthenticate() {
        if Auth.auth().currentUser != nil {
            getUserData()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ) { [weak self] in
                self?.performSegue(withIdentifier: UnwindIdentifier.identifier(for: .LoginPage), sender: nil)
            }
        }
    }
    
    private func getUserData() {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(currentUserUid).observe(.value) { [weak self] (snapshot) in
            guard let self = self,
                let userDic = snapshot.value as? NSDictionary,
                let displayName = userDic["displayName"] as? String,
                let email = userDic["email"] as? String,
                let photoURL = userDic["photoURL"] as? String else { return }
            CurrentUser.addCurrentUser(name: displayName, photoURL: photoURL, email: email)
            self.performSegue(withIdentifier: UnwindIdentifier.identifier(for: .App), sender: nil)
        }
    }
}
