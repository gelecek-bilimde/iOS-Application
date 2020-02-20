//
//  SignInWithAppleAuth.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 20.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth
import FirebaseDatabase

class SignInWithAppleAuth: NSObject, ASAuthorizationControllerDelegate {
    
    let defaults = UserDefaults.standard
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    var currentVC: UIViewController = UIViewController()
    
    init(vc: UIViewController) {
        super.init()
        self.currentVC = vc
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        //authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func writeUserToDB(user: User, email: String, fullName: String) {
        let appUser = AppUser(name: fullName, photoURL: "", email: email)
        let userDic: [String:Any] = ["displayName": fullName, "email": email, "photoURL": "", "providerID": user.providerID]
        Database.database().reference().child("Users").child(user.uid).setValue(userDic)
        CurrentUser.addCurrentUser(name: appUser.name, photoURL: appUser.photoURL, email: appUser.email)
        self.currentVC.performSegue(withIdentifier: "goToInitialPage", sender: nil)
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

@available(iOS 13.0, *)
extension SignInWithAppleAuth {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let hud = CustomProgressHUD()
        hud.play(view: currentVC.view)
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                hud.stop()
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                hud.stop()
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                hud.stop()
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authUser, error) in
                if let error = error{
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    hud.stop()
                    print(error.localizedDescription)
                    return
                } else {
                    guard let userResult = authUser?.user else { return }
                    if appleIDCredential.email != nil {
                        hud.stop()
                        self.defaults.set("\(String(describing: appleIDCredential.fullName!.givenName!)) \(String(describing: appleIDCredential.fullName!.familyName!))", forKey: "AppleDisplayName")
                        self.defaults.set(appleIDCredential.email!, forKey: "AppleEmail")
                        self.writeUserToDB(user: userResult, email: appleIDCredential.email!, fullName: "\(String(describing: appleIDCredential.fullName!.givenName!)) \(String(describing: appleIDCredential.fullName!.familyName!))")
                    } else {
                        hud.stop()
                        let name = self.defaults.string(forKey: "AppleDisplayName")
                        let email = self.defaults.string(forKey: "AppleEmail")
                        CurrentUser.addCurrentUser(name: name!, photoURL: "", email: email!)
                        self.currentVC.performSegue(withIdentifier: "goToInitialPage", sender: nil)
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}
