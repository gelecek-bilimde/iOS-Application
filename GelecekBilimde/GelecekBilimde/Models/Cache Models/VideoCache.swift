//
//  VideoCache.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 14.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift

class VideoCache: Object {
    @objc dynamic var videoURLId: String = ""
    @objc dynamic var videoDate: String = ""
    @objc dynamic var videoImageURL: String = ""
    @objc dynamic var videoTitle: String = ""
    @objc dynamic var bookmarked: Bool = false
    
    override static func primaryKey() -> String? {
        return "videoURLId"
    }
}
