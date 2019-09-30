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
          return true
      }
      
      func applicationWillTerminate(_ application: UIApplication) {
          CoreDataManager.shared.saveContext()
      }
}

// MARK: - Auxiliary Methods
extension AppDelegate {
    
    func setTabbarCostumuzation() {
        //For Tab Bar customizations
        UITabBar.appearance().barTintColor = UIColor.barTintColor
        UITabBar.appearance().tintColor = UIColor.tintColor
    }
}

