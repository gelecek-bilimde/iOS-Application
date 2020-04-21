//
//  ProfileDelegate.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.04.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAuth
import GoogleSignIn


class ProfileDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var currentVC: UIViewController = UIViewController()
    
    init(vc: UIViewController) {
        super.init()
        currentVC = vc
    }
    
    var settingNames = ["Bizi Destekle", "Twitch", "Youtube", "Twitter", "Instagram", "Spotify", "Geliştirici Bilgileri", "Çıkış Yap"]
    var settingImages = ["supportIcon", "twitchIcon", "youtubeWhiteIcon", "twitterIcon", "instagramIcon", "spotifyIcon", "developerIcon", "logoutIcon"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentName = settingNames[indexPath.row]
        let currentImageName = settingImages[indexPath.row]
        let image = UIImage(named: currentImageName)
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        cell.setSetting(name: currentName, image: image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSetting = settingNames[indexPath.row]
        switch currentSetting {
        case "Bizi Destekle":
            openSiteOnSafari(url: "https://www.gelecekbilimde.net/destek")
        case "Instagram":
            if !openInAppIsExist(url: "instagram://user?username=gelecekbilimde") {
                openSiteOnSafari(url: "https://www.instagram.com/gelecekbilimde")
            }
        case "Spotify":
            if !openInAppIsExist(url: "spotify:show:7sOZipKq6PbX2REe9zqLml") {
                openSiteOnSafari(url: "https://open.spotify.com/show/7sOZipKq6PbX2REe9zqLml?nd=1")
            }
        case "Youtube":
            if !openInAppIsExist(url: "youtube://www.youtube.com/channel/UC03cpKIZShIWoSBhfVE5bog") {
                openSiteOnSafari(url: "https://www.youtube.com/channel/UC03cpKIZShIWoSBhfVE5bog")
            }
        case "Twitch":
            if !openInAppIsExist(url: "twitch://open?stream=gelecekbilimde") {
                openSiteOnSafari(url: "https://www.twitch.tv/gelecekbilimde")
            }
        case "Twitter":
            if !openInAppIsExist(url: "twitter://user?screen_name=gelecekbilimde") {
                openSiteOnSafari(url: "https://twitter.com/gelecekbilimde")
            }
        case "Geliştirici Bilgileri":
            openSiteOnSafari(url: "https://alperen-homepage.now.sh")
        case "Çıkış Yap":
            signOut()
        default:
            print("error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func openSiteOnSafari(url: String){
        guard let siteURL = URL(string: url) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        
        let vc = SFSafariViewController(url: siteURL, configuration: config)
        vc.preferredBarTintColor = UIColor.barTintColor
        vc.preferredControlTintColor = UIColor.customGreen
        currentVC.present(vc, animated: true)
    }
    func openInAppIsExist(url: String) -> Bool {
        guard let siteURL = URL(string: url) else { return false }
        if UIApplication.shared.canOpenURL(siteURL) {
            UIApplication.shared.open(siteURL, options: [:])
            return true
        } else {
            return false
        }
    }
    func signOut(){
        try? Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        CurrentUser.clearCurrentUser()
        currentVC.dismiss(animated: true)
    }
    
}
