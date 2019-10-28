//
//  CurrentUser.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 28.10.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

class CurrentUser {
    static var currentUser = User(accessToken: "", name: "", email: "")
    
    private init(){}
    
    static func addCurrentUser(accessToken: String, name: String, email: String) {
        currentUser.accessToken = accessToken
        currentUser.name = name
        currentUser.email = email
    }
    
    static func clearCurrentUser() {
        currentUser.accessToken = ""
        currentUser.name = ""
        currentUser.email = ""
    }
}
