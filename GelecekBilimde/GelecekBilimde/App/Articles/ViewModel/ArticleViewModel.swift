//
//  ArticleViewModel.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase

class ArticleViewModel {
    
    let networkManager = NetworkManager()
    let realm = try! Realm()
    var articlesCache: Results<ArticleCache>?
    var articles = [ArticleResponse]()
    
    
    func loadArticlesCache() {
        articlesCache = realm.objects(ArticleCache.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func getArticles(page: Int, completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            self.articles.removeAll()
        }
        networkManager.getArticles(page: page) { (articles, error) in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    guard let articles = articles else { return }
                    
                    self.articles.append(contentsOf: articles)
                    
//                    for i in 0..<self.articles.count {
//                        Database.database().reference().child("Articles").child(String(self.articles[i].id)).observe(.value) { (snapshot) in
//                            if let userDic = snapshot.value as? NSDictionary {
//                                if let articleImageURL = userDic["articleImageURL"] as? String {
//                                    print(articleImageURL)
//                                    self.articles[i].imageURL = articleImageURL
//                                }
//                            }
//                            self.writeArticleToCache(article: self.articles[i])
//                            completion()
//                        }
//                    }
                    self.writeAll()
                    self.updateArticleImages()
                    completion()
                }
            }
        }
    }
    func updateArticleImages(){
        for article in articlesCache! {
            Database.database().reference().child("Articles").child(String(article.id)).observe(.value) { (snapshot) in
                if let userDic = snapshot.value as? NSDictionary {
                    if let articleImageURL = userDic["articleImageURL"] as? String {
                        do {
                            try self.realm.write {
                                article.imageURL = articleImageURL
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func writeAll() {
        for article in articles {
            let existingPerson = realm.object(ofType: ArticleCache.self, forPrimaryKey: article.id)
            
            if let _ = existingPerson {
                
            } else {
                // Add article
                do{
                    try realm.write {
                        let articleCache = ArticleCache()
                        articleCache.id = article.id
                        articleCache.date = findDateFromString(dateString: article.date)
                        articleCache.link = article.link
                        articleCache.content = article.content.rendered
                        articleCache.title = article.title.rendered
                        articleCache.imageURL = article.imageURL ?? ""
                        articleCache.excrpt = article.excerpt.rendered
                        realm.add(articleCache)
                    }
                }
                catch{
                    print("Error: \(error)")
                }
            }
        }
        
        
    }
    
    func writeArticleToCache(article: ArticleResponse) {
        
            let existingPerson = realm.object(ofType: ArticleCache.self, forPrimaryKey: article.id)
        
            if let _ = existingPerson {
                
            } else {
                // Add article
                do{
                    try realm.write {
                        let articleCache = ArticleCache()
                        articleCache.id = article.id
                        articleCache.date = findDateFromString(dateString: article.date)
                        articleCache.link = article.link
                        articleCache.content = article.content.rendered
                        articleCache.title = article.title.rendered
                        articleCache.imageURL = article.imageURL ?? ""
                        articleCache.excrpt = article.excerpt.rendered
                        realm.add(articleCache)
                    }
                }
                catch{
                    print("Error: \(error)")
                }
            }
        
    }
    
    func findDateFromString(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    func clearArticleCache(){
          do{
              try self.realm.write {
                  loadArticlesCache()
                  //And delete main page contents in cache
                  realm.delete(articlesCache!)
              }
          }
          catch{
              print("Error: \(error)")
          }
      }
    func changeArticleBookmark(article: ArticleCache, state: Bool){
        let article = realm.objects(ArticleCache.self).filter("id == %@", article.id).first
        
        do{
            try realm.write {
                article?.bookmarked = state
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "articleBookmarkChange"), object: nil,
                userInfo: nil)
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
}
