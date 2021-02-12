//
//  BookmarkedVideosTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class BookmarkedVideosTableViewController: UITableViewController {

    private var bookmarkVideoVM: BookmarkVideoViewModel!
    private lazy var emptyMessageView: EmptyStateView = {
        // TODO: Baris - Here we need a specific empty message.
        return EmptyStateView(frame: tableView.frame, message: "Henüz bir videoyu favorilerinize eklemediniz.")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkVideoVM = BookmarkVideoViewModel()
        refreshArticles()
        //This is for setting table view's background color
        self.tableView.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(refreshArticles), name: NSNotification.Name(rawValue: "videoBookmarkChange"), object: nil)
    }
    
    @objc func refreshArticles() {
        bookmarkVideoVM.loadBookmarkedVideos()
        tableView.reloadData()
    }
    
    func didTapBookmark(video: VideoCache) {
        bookmarkVideoVM.changeVideoBookmark(video: video, state: !video.bookmarked)
        refreshArticles()
    }
    
    private func numberOfRows() -> Int {
        guard let count = bookmarkVideoVM.bookmarkedVideos?.count, count > 0 else {
            configureEmptyMessage(true)
            return 0 }
        configureEmptyMessage()
        return count
    }
    
    private func configureEmptyMessage(_ isShow: Bool = false) {
        tableView.separatorStyle = isShow ? .none : .singleLine
        tableView.backgroundView = isShow ? emptyMessageView : nil
    }
}

// MARK: - Table view data source
extension BookmarkedVideosTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentVideo = bookmarkVideoVM.bookmarkedVideos?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoBookmarkCell", for: indexPath) as! VideoTableViewCell
        cell.didVideoBookmarked = { [weak self] video in
            self?.didTapBookmark(video: video)
        }
        cell.setVideo(videoCache: currentVideo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: UnwindIdentifier.identifier(for: .VideoContentFromBookmark), sender: nil)
    }
    
}

//MARK: Prepare for Segue
extension BookmarkedVideosTableViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
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
