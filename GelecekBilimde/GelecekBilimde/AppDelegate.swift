//
//  AppDelegate.swift
//  GelecekBilimde
//
//  Created by Burak Furkan Asilturk on 28.08.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setTabbarCostumuzation()
        setUserAgentForGoogleSignIn()
        return true
    }
}

// MARK: - Auxiliary Methods
extension AppDelegate {
    
    func setTabbarCostumuzation() {
        //For Tab Bar customizations
        UITabBar.appearance().barTintColor = UIColor.barTintColor
        UITabBar.appearance().tintColor = UIColor.tintColor
    }
    
    func setUserAgentForGoogleSignIn() {
        let dictionary = NSDictionary(object: "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36", forKey: "UserAgent" as NSCopying)
        UserDefaults.standard.register(defaults: dictionary as! [String : Any])
    }
    
}

