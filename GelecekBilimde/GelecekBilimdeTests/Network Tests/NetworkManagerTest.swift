//
//  NetworkManagerTest.swift
//  GelecekBilimdeTests
//
//  Created by Alperen Ünal on 31.03.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import XCTest
@testable import GelecekBilimde

class NetworkManagerTest: XCTestCase {
    //sut = System Under Test
    var sut: NetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetArticlesFromAPI() {
        let sessionAnsweredExpectation = expectation(description: "Session")
        sut.getArticles(page: 1) { (articles, error) in
            if let error = error {
                XCTFail(error)
            } else {
                guard let articles = articles else { XCTFail("Articles returning nil") ; return }
                sessionAnsweredExpectation.fulfill()
                XCTAssertNotEqual(articles.count, 0)
            }
        }
        waitForExpectations(timeout: 8, handler: nil)
    }

}
