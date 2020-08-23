//
//  Destination.swift
//  GelecekBilimde
//
//  Created by Burak Furkan Asilturk on 30.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit


private struct _Storyboard {
    
    static let Bookmarks = UIStoryboard.init(name: "Bookmarks", bundle: nil)
    static let Login = UIStoryboard.init(name: "Login", bundle: nil)
    static let InitialTabBar = UIStoryboard.init(name: "Initial", bundle: nil)
    static let Articles = UIStoryboard.init(name: "Articles", bundle: nil)
    static let Videos = UIStoryboard.init(name: "Videos", bundle: nil)
    static let Profile = UIStoryboard.init(name: "Profile", bundle: nil)
}

/// This class used for store and manage view controller classes from one point
/// Sample usage: let targetVC = Destination().targetVC
/// Team should consider here. Force unwrap is always risky.
struct Destination {
    let Bookmarks = _Storyboard.Bookmarks.instantiateViewController(withIdentifier: "bookmarksViewController") as! BookmarksViewController
    let BookmarkedArticles = _Storyboard.Bookmarks.instantiateViewController(withIdentifier: "bookmarkedArticles") as! BookmarkedArticlesTableViewController
    let BookmarkedVideos = _Storyboard.Bookmarks.instantiateViewController(withIdentifier: "bookmarkedVideos") as! BookmarkedVideosTableViewController
    let Login = _Storyboard.Login.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
    let InitialTabBar = _Storyboard.InitialTabBar.instantiateViewController(withIdentifier: "initialTabBarViewController") as! InitialTabBarViewController
    let Articles = _Storyboard.Articles.instantiateViewController(withIdentifier: "articlesTableViewController") as! ArticlesTableViewController
    let Videos = _Storyboard.Videos.instantiateViewController(withIdentifier: "videosTableViewController") as! VideosTableViewController
    let Profile = _Storyboard.Profile.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
}

struct UnwindIdentifier {
    enum Route: String {
        case LoginPage
        case App
        case ArticleContentFromBookmark
        case VideoContentFromBookmark
        case ArticleContent
        case VideoContent
        case InitialPage
    }
    
    static func identifier(for route: Route) -> String {
        "goTo" + route.rawValue
    }
}
