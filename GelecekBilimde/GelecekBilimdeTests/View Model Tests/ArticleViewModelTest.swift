//
//  ArticleViewModelTest.swift
//  GelecekBilimdeTests
//
//  Created by Alperen Ünal on 31.03.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import XCTest
@testable import GelecekBilimde
import RealmSwift

class ArticleViewModelTest: XCTestCase {
    
    //sut = System Under Test
    var sut: ArticleViewModel!
    var realm: Realm!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ArticleViewModel()
        realm = RealmProvider.realm()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try! realm.write {
            realm.deleteAll()
        }
        try super.tearDownWithError()
    }
    
    func saveArticleToCache(article: ArticleCache){
        do {
            try realm.write {
                realm.add(article)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSaveArticleToCache() {
        let content = Content(rendered: "content")
        let title = Title(rendered: "title")
        let excerpt = Excerpt(rendered: "excrpt")
        let article = ArticleResponse(id: 1, date: "2020-03-31T12:14:00", link: "link", content: content, title: title, excerpt: excerpt, imageURL: nil)
        
        let articleCache = ArticleCache()
        articleCache.id = article.id
        articleCache.date = sut.findDateFromString(dateString: article.date)
        articleCache.link = article.link
        articleCache.content = article.content.rendered
        articleCache.title = article.title.rendered
        articleCache.imageURL = article.imageURL ?? ""
        articleCache.excrpt = article.excerpt.rendered
        saveArticleToCache(article: articleCache)
        
        let lastArticleFromCache = realm.objects(ArticleCache.self).last
        //Check is equal
        XCTAssertEqual(articleCache, lastArticleFromCache)
    }

}
