//
//  ArticleResponseModelTest.swift
//  GelecekBilimdeTests
//
//  Created by Alperen Ünal on 31.03.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import XCTest
@testable import GelecekBilimde

class ArticleResponseModelTest: XCTestCase {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testArticleResponseModel() throws {
        let content = Content(rendered: "content")
        let title = Title(rendered: "title")
        let excerpt = Excerpt(rendered: "excrpt")
        let articleResponse = ArticleResponse(id: 1, date: "12.12.12", link: "link", content: content, title: title, excerpt: excerpt, imageURL: nil)
        
        let data = try encoder.encode(articleResponse)
        let decodedArticleResponse = try decoder.decode(ArticleResponse.self, from: data)
        
        XCTAssertEqual(articleResponse, decodedArticleResponse)
    }

}
