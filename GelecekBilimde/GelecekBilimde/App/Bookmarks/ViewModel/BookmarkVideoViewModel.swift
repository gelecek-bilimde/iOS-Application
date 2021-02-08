//
//  BookmarkVideoViewModel.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 16.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift

final class BookmarkVideoViewModel {
    let realm = try! Realm()
    var bookmarkedVideos: Results<VideoCache>?
    
    func loadBookmarkedVideos(){
        bookmarkedVideos = realm.objects(VideoCache.self).filter("bookmarked == True")
    }
    
    func changeVideoBookmark(video: VideoCache, state: Bool) {
        let video = realm.objects(VideoCache.self).filter("videoURLId == %@", video.videoURLId).first
        
        do {
            try realm.write {
                video?.bookmarked = state
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoBookmarkChangeFromBookmark"), object: nil,
                                                userInfo: nil)
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
}
