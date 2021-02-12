//
//  ArticleCache.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleCache: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var link: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var excrpt: String = ""
    @objc dynamic var bookmarked: Bool = false
    @objc dynamic var category: Int = -1
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
