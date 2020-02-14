//
//  ArticleResponse.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    var id: Int
    var date: String
    var link: String
    var content: Content
    var title: Title
    var excerpt: Excerpt
    var imageURL: String?
}

struct Content: Decodable {
    var rendered: String
}

struct Title: Decodable {
    var rendered: String
}
struct Excerpt: Decodable {
    var rendered: String
}
