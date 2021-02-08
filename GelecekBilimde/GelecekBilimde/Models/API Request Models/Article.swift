//
//  ArticleResponse.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

struct Article: Codable, Equatable {
    
    var id: Int
    var date: String
    var link: String
    var content: Content
    var title: Title
    var excerpt: Excerpt
    var imageURL: String?
    var categories: [Category]
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id && lhs.date == rhs.date && lhs.link == rhs.link && lhs.content == rhs.content && lhs.title == rhs.title && lhs.excerpt == rhs.excerpt && lhs.imageURL == rhs.imageURL
    }
}

struct Content: Codable, Equatable {
    var rendered: String
}

struct Title: Codable, Equatable {
    var rendered: String
}
struct Excerpt: Codable, Equatable {
    var rendered: String
}
