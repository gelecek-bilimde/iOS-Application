//
//  CurrentUser.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 28.10.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

class CurrentUser {
    static var currentUser = AppUser(name: "", photoURL: "", email: "")
    
    private init(){}
    
    static func addCurrentUser(name: String, photoURL: String, email: String) {
        currentUser.photoURL = photoURL
        currentUser.name = name
        currentUser.email = email
    }
    
    static func clearCurrentUser() {
        currentUser.photoURL = ""
        currentUser.name = ""
        currentUser.email = ""
    }
}
