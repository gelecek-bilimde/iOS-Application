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

final class ArticleViewModel {
    
    let realm = try! Realm()
    var articlesCache: Results<ArticleCache>?
    var articles = [Article]()
    let resource = ArticleResource()
    var selectedCategory: ArticleCategory?
    var currentpage = 1
    var selectedDate: Date?
    
    func loadArticlesCache() {
        guard let categoryId = selectedCategory?.category.rawValue else {
            guard let date = selectedDate else {
                articlesCache = realm.objects(ArticleCache.self).sorted(byKeyPath: "date", ascending: false)
                return
            }
            articlesCache = realm.objects(ArticleCache.self).filter("date > %@", date).sorted(byKeyPath: "date", ascending: false)
            return }
        
        guard let date = selectedDate else {
            articlesCache = realm.objects(ArticleCache.self).filter("category == %@", categoryId).sorted(byKeyPath: "date", ascending: false)
            return
        }
        articlesCache = realm.objects(ArticleCache.self).filter("category == %@", categoryId).filter("date > %@", date).sorted(byKeyPath: "date", ascending: false)
    }
    
    func didSelect(category: ArticleCategory? = nil, date: Date?, completion: @escaping () -> ()) {
        selectedCategory = category
        selectedDate = date
        getArticles {
            completion()
        }
    }
    
    func getArticles(completion: @escaping () -> ()) {
        articles.removeAll()
        resource.retrieveArticleList(page: selectedCategory?.page ?? currentpage,
                                     category: selectedCategory?.category.rawValue,
                                     date: selectedDate) { [weak self] result in
            if case .success(let articles) = result {
                guard let self = self,
                      let articles = articles! else { return }
                if self.selectedCategory != nil {
                    self.selectedCategory?.page += 1
                } else {
                    self.currentpage += 1
                }
                self.articles.append(contentsOf: articles)
                self.writeAll()
                self.updateArticleImages()
            }
            completion()
        }
    }
    
    func updateArticleImages() {
        guard let articles = articlesCache else { return }
        for article in articles {
            Database.database().reference().child("Articles").child(String(article.id)).observe(.value) { [weak self] snapshot in
                guard let userDic = snapshot.value as? NSDictionary,
                      let articleImageURL = userDic["articleImageURL"] as? String else { return }
                do {
                    try self?.realm.write {
                        article.imageURL = articleImageURL
                    }
                } catch {
                    print(error)
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
                do {
                    try realm.write {
                        let articleCache = ArticleCache()
                        articleCache.id = article.id
                        articleCache.date = findDateFromString(dateString: article.date)
                        articleCache.link = article.link
                        articleCache.content = article.content.rendered
                        articleCache.title = article.title.rendered
                        articleCache.imageURL = article.imageURL ?? ""
                        articleCache.excrpt = article.excerpt.rendered
                        articleCache.category = selectedCategory?.category.rawValue ?? -1
                        realm.add(articleCache)
                    }
                } catch {
                    print("Error: \(error)")
                }
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

protocol ArticleResourceProtocol: QuaResponse {
    func retrieveArticleList(page: Int, category: Int?, date: Date?, completion: @escaping Handler<Result<[Article]?>>)
}

class ArticleResource: ArticleResourceProtocol {
    init() {
    }
    
    func retrieveArticleList(page: Int, category: Int?, date: Date?, completion: @escaping Handler<Result<[Article]?>>) {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(10)")]
        if let category = category {
            queryItems.append(URLQueryItem(name: "categories", value: "\(category)"))
        }
        if let date = date {
            queryItems.append(contentsOf: date.gbAPIComponent() ?? [])
        }
        retrieve(.init(path: "posts", queryItems: queryItems)) { result in
            completion(result)
        }
    }
}
