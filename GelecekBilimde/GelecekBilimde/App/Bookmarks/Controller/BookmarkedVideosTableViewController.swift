//
//  BookmarkedVideosTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class BookmarkedVideosTableViewController: UITableViewController {

    var bookmarkVideoVM: BookmarkVideoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkVideoVM = BookmarkVideoViewModel()
        bookmarkVideoVM.loadBookmarkedVideos()
        tableView.reloadData()
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
        NotificationCenter.default.addObserver(self, selector: #selector(refreshArticles), name: NSNotification.Name(rawValue: "videoBookmarkChange"), object: nil)
    }
    
    @objc func refreshArticles(){
        bookmarkVideoVM.loadBookmarkedVideos()
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension BookmarkedVideosTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarkVideoVM.bookmarkedVideos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentVideo = bookmarkVideoVM.bookmarkedVideos?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoBookmarkCell", for: indexPath) as! VideoTableViewCell
        cell.delegate = self
        cell.setVideo(videoCache: currentVideo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToVideoContentFromBookmark", sender: nil)
    }
    
}

//MARK: Prepare for Segue
extension BookmarkedVideosTableViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Geri"
        navigationItem.backBarButtonItem = backItem
        if let destinationVC = segue.destination as? VideoContentViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let video = bookmarkVideoVM.bookmarkedVideos?[indexPath.row]
                
                guard let content = video else { return }
                
                destinationVC.currentVideo = content
            }
        }
    }
}

//MARK: Article Cell Delegate
extension BookmarkedVideosTableViewController: VideoCellDelegate {
    func didTapBookmark(video: VideoCache) {
        if video.bookmarked {
            //Set False
            bookmarkVideoVM.changeVideoBookmark(video: video, state: false)
            bookmarkVideoVM.loadBookmarkedVideos()
            tableView.reloadData()
        } else {
            //Set True
            bookmarkVideoVM.changeVideoBookmark(video: video, state: true)
            bookmarkVideoVM.loadBookmarkedVideos()
            tableView.reloadData()
        }
    }
}

