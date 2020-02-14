//
//  BookmarkedArticlesTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class BookmarkedArticlesTableViewController: UITableViewController {
    
    var bookmarkArticleVM: BookmarkArticleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkArticleVM = BookmarkArticleViewModel()
        bookmarkArticleVM.loadBookmarkedArticles()
        tableView.reloadData()
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
        NotificationCenter.default.addObserver(self, selector: #selector(refreshArticles), name: NSNotification.Name(rawValue: "articleBookmarkChange"), object: nil)
    }
    
    @objc func refreshArticles(){
        bookmarkArticleVM.loadBookmarkedArticles()
        tableView.reloadData()
    }
    
}
// MARK: - Table view data source
extension BookmarkedArticlesTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarkArticleVM.bookmarkedArticles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentArticle = bookmarkArticleVM.bookmarkedArticles?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.delegate = self
        cell.setArticle(article: currentArticle)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToArticleContentFromBookmark", sender: nil)
    }
    
}

//MARK: Prepare for Segue
extension BookmarkedArticlesTableViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Geri"
        navigationItem.backBarButtonItem = backItem
        if let destinationVC = segue.destination as? ArticleContentViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = bookmarkArticleVM.bookmarkedArticles?[indexPath.row]
                
                guard let content = article else { return }
                
                destinationVC.currentArticle = content
            }
        }
    }
}

//MARK: Article Cell Delegate
extension BookmarkedArticlesTableViewController: ArticleCellDelegate {
    func didTapBookmark(article: ArticleCache) {
        if article.bookmarked {
            //Set False
            bookmarkArticleVM.changeArticleBookmark(article: article, state: false)
            bookmarkArticleVM.loadBookmarkedArticles()
            tableView.reloadData()
        } else {
            //Set True
            bookmarkArticleVM.changeArticleBookmark(article: article, state: true)
            bookmarkArticleVM.loadBookmarkedArticles()
            tableView.reloadData()
        }
    }
}
