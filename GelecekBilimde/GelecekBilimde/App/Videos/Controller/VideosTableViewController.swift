//
//  VideosTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class VideosTableViewController: UITableViewController {
    
    var videosViewModel: VideosViewModel!
    private var fetchingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //NavBar title customizations
        navigationController?.navigationBar.barTintColor = UIColor.barTintColor
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshVideos), name: NSNotification.Name(rawValue: "videoBookmarkChangeFromBookmark"), object: nil)
        videosViewModel = VideosViewModel()
        videosViewModel.loadVideosCache()
        
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
        
        videosViewModel.getVideos {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.videosViewModel.loadVideosCache()
                self.tableView.reloadData()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                getMoreVideos()
            }
        }
    }
    
    func getMoreVideos() {
        fetchingMore = true
        videosViewModel.getVideos {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.fetchingMore = false
                self.videosViewModel.loadVideosCache()
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func refreshVideos() {
         videosViewModel.loadVideosCache()
         tableView.reloadData()
    }
    
    func didTapBookmark(video: VideoCache) {
        videosViewModel.changeVideoBookmark(video: video, state: !video.bookmarked)
        videosViewModel.loadVideosCache()
        tableView.reloadData()
    }
}



//MARK: Prepare for Segue
extension VideosTableViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Geri"
        navigationItem.backBarButtonItem = backItem
        if let destinationVC = segue.destination as? VideoContentViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let video = videosViewModel.videosCache?[indexPath.row] else { return }
                destinationVC.currentVideo = video
            }
        }
    }
}
