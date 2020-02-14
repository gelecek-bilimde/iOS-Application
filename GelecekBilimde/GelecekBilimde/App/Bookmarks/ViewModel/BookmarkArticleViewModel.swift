//
//  BookmarkArticleViewModel.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 14.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift

class BookmarkArticleViewModel {
    let realm = try! Realm()
    var bookmarkedArticles: Results<ArticleCache>?
    
    func loadBookmarkedArticles(){
        bookmarkedArticles = realm.objects(ArticleCache.self).filter("bookmarked == True")
    }
    
    func changeArticleBookmark(article: ArticleCache, state: Bool){
        let article = realm.objects(ArticleCache.self).filter("id == %@", article.id).first
        
        do{
            try realm.write {
                article?.bookmarked = state
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "articleBookmarkChangeFromBookmark"), object: nil,
                userInfo: nil)
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
}
