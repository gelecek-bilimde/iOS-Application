//
//  Authentication.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 28.10.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import AeroGearOAuth2
import AeroGearHttp

class Authentication {
    //This is a Keycloak Config for Authentication
    private let http = Http()
    private let keycloakConfig = KeycloakConfig(
        clientId: "app",
        host: "https://giris.gelecekbilimde.net",
        realm: "master",
        isOpenIDConnect: true)
    //Singleton pattern object
    static var sharedInstance = Authentication()
    //Private initializer for singleton pattern
    private init(){
         self.keycloakConfig.webView = Config.WebViewType.embeddedWebView
    }
    
    func authenticate(completion: @escaping(Result<User, Error>)->()) {
        //Set oAuth2 module with Keycloak Config
        let oauth2Module = AccountManager.addKeycloakAccount(config: self.keycloakConfig)
        http.authzModule = oauth2Module
        //Login with oAuth2 module's login function
        oauth2Module.login(){ (token, claim, error) in
             if let error = error {
                completion(.failure(error))
             } else {
                guard let accessToken = token as? String else { return }
                guard let name = claim?.name else { return }
                guard let email = claim?.email else { return }
                
                let user = User(accessToken: accessToken, name: name, email: email)
                
                completion(.success(user))
             }
         }
    }
    
    func logout() {
        //Set oAuth2 module with Keycloak Config
        let oauth2Module = AccountManager.addKeycloakAccount(config: keycloakConfig)
        http.authzModule = oauth2Module
        //Clear session tokens
        oauth2Module.oauth2Session.clearTokens()
        //Clear URL Cache
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        //Clear cookies in the web view
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies {
            for cookie in cookies {
                storage.deleteCookie(cookie)
            }
        }
    }
}
