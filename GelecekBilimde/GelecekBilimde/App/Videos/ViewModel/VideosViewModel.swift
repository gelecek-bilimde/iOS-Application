//
//  VideosViewModel.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 14.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase

class VideosViewModel {
    let realm = try! Realm()
    var videosCache: Results<VideoCache>?
    var dbLastVideo: VideoCache?
    var lastVideo: VideoCache?
    
    func loadVideosCache() {
        videosCache = realm.objects(VideoCache.self).sorted(byKeyPath: "videoDate", ascending: false)
    }
    
    func getVideos(completion: @escaping () -> ()){
        let videosRef = Database.database().reference().child("Videos")
        dbLastVideo = videosCache?.last
        var queryRef: DatabaseQuery
        if lastVideo == nil {
            queryRef = videosRef.queryOrdered(byChild: "videoDate").queryLimited(toLast: 10)
        } else {
            queryRef = videosRef.queryOrdered(byChild: "videoDate").queryEnding(atValue: dbLastVideo!.videoDate).queryLimited(toLast: 10)
        }
        queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                guard let childDatasnapshot = child as? DataSnapshot else { return }
                if let userDic = childDatasnapshot.value as? NSDictionary {
                    guard let videoURLId = userDic["videoURLId"] as? String else { return }
                    guard let videoDate = userDic["videoDate"] as? String else { return }
                    guard let videoTitle = userDic["videoTitle"] as? String else { return }
                    guard let videoImageURL = userDic["videoImageURL"] as? String else { return }
                    let videoCache = VideoCache()
                    videoCache.videoDate = videoDate
                    videoCache.videoURLId = videoURLId
                    videoCache.videoTitle = videoTitle
                    videoCache.videoImageURL = videoImageURL
                    self.lastVideo = videoCache
                    self.addToCache(videoCache: videoCache)
                }
            }
            completion()
        }, withCancel: { (error) in
            DispatchQueue.main.async {
                print(error)
            }
        })
    }
    
    func addToCache(videoCache: VideoCache){
        let existingVideo = realm.object(ofType: VideoCache.self, forPrimaryKey: videoCache.videoURLId)
        
        if let _ = existingVideo {
        } else {
            // Add video
            do{
                try realm.write {
                    realm.add(videoCache)
                }
            }
            catch{
                print("Error: \(error)")
            }
        }
    }
    func clearVideosCache(){
        do{
            try self.realm.write {
                loadVideosCache()
                //And delete main page contents in cache
                realm.delete(videosCache!)
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
    
    func changeVideoBookmark(video: VideoCache, state: Bool){
        let video = realm.objects(VideoCache.self).filter("videoURLId == %@", video.videoURLId).first
        
        do{
            try realm.write {
                video?.bookmarked = state
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoBookmarkChange"), object: nil,
                userInfo: nil)
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
    
}
