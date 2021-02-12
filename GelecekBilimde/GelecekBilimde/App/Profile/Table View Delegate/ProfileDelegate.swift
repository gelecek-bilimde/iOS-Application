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


final class ProfileDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    struct ProfileItem {
        enum ItemType {
            case support
            case twitch
            case youtube
            case twitter
            case instagram
            case spotify
            case developerInfo
            case signOut
            case header
        }
        let type: ItemType
        let name: String
        let imageName: String
    }
    
    private var currentVC: UIViewController = UIViewController()
    
    init(vc: UIViewController) {
        super.init()
        currentVC = vc
    }
    
    private let profileItemList: [ProfileItem] = [.init(type: .header, name: "Destek", imageName: ""),
                                          .init(type: .support, name: "Bizi Destekle", imageName: "supportIcon"),
                                          .init(type: .header, name: "Sosyal Medya", imageName: ""),
                                          .init(type: .twitch, name: "Twitch", imageName: "twitchIcon"),
                                          .init(type: .youtube, name: "Youtube", imageName: "youtubeWhiteIcon"),
                                          .init(type: .twitter, name: "Twitter", imageName: "twitterIcon"),
                                          .init(type: .instagram, name: "İnstagram", imageName: "instagramIcon"),
                                          .init(type: .spotify, name: "Spotify", imageName: "spotifyIcon"),
                                          .init(type: .header, name: "Geliştirici Bilgileri", imageName: ""),
                                          .init(type: .developerInfo, name: "Alperen Ünal", imageName: "developerIcon"),
                                          .init(type: .developerInfo, name: "Barış Uyar", imageName: "developerIcon"),
                                          .init(type: .header, name: "", imageName: ""),
                                          .init(type: .signOut, name: "Çıkış Yap", imageName: "logoutIcon")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { profileItemList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = profileItemList[indexPath.row]
        if case .header = item.type {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderCell
            cell.set(name: item.name)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
            cell.setSetting(name: item.name, image: UIImage(named: item.imageName) ?? .init())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = profileItemList[indexPath.row]
        switch item.type {
        case .support:
            openSiteOnSafari(url: "https://www.gelecekbilimde.net/destek")
        case .instagram:
            if !openInAppIsExist(url: "instagram://user?username=gelecekbilimde") {
                openSiteOnSafari(url: "https://www.instagram.com/gelecekbilimde")
            }
        case .spotify:
            if !openInAppIsExist(url: "spotify:show:7sOZipKq6PbX2REe9zqLml") {
                openSiteOnSafari(url: "https://open.spotify.com/show/7sOZipKq6PbX2REe9zqLml?nd=1")
            }
        case .youtube:
            if !openInAppIsExist(url: "youtube://www.youtube.com/channel/UC03cpKIZShIWoSBhfVE5bog") {
                openSiteOnSafari(url: "https://www.youtube.com/channel/UC03cpKIZShIWoSBhfVE5bog")
            }
        case .twitch:
            if !openInAppIsExist(url: "twitch://open?stream=gelecekbilimde") {
                openSiteOnSafari(url: "https://www.twitch.tv/gelecekbilimde")
            }
        case .twitter:
            if !openInAppIsExist(url: "twitter://user?screen_name=gelecekbilimde") {
                openSiteOnSafari(url: "https://twitter.com/gelecekbilimde")
            }
        case .developerInfo:
            if item.name.contains("Alperen") {
                openSiteOnSafari(url: "https://alperen-homepage.now.sh")
            } else {
                openSiteOnSafari(url: "https://barisuyar.com/about/")
            }
        case .signOut:
            signOut()
        default:
            print("error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func openSiteOnSafari(url: String) {
        guard let siteURL = URL(string: url) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        
        let vc = SFSafariViewController(url: siteURL, configuration: config)
        vc.preferredBarTintColor = UIColor.barTintColor
        vc.preferredControlTintColor = UIColor.white
        currentVC.present(vc, animated: true)
    }
    
    private func openInAppIsExist(url: String) -> Bool {
        guard let siteURL = URL(string: url) else { return false }
        if UIApplication.shared.canOpenURL(siteURL) {
            UIApplication.shared.open(siteURL, options: [:])
            return true
        } else {
            return false
        }
    }
    
    private func signOut() {
        try? Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        CurrentUser.clearCurrentUser()
        currentVC.dismiss(animated: true)
    }
    
}
