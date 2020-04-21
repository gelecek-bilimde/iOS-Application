//
//  ArticlesTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    private var currentPage = 1
    var articleViewModel: ArticleViewModel!
    private var fetchingMore = false
    private let hud = CustomProgressHUD()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(getFreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NavBar title customizations
        navigationController?.navigationBar.barTintColor = UIColor.barTintColor
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshArticles), name: NSNotification.Name(rawValue: "articleBookmarkChangeFromBookmark"), object: nil)
        articleViewModel = ArticleViewModel()
        articleViewModel.loadArticlesCache()
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
        self.tableView.refreshControl = refresher
        hud.play(view: view)
        articleViewModel.getArticles(page: currentPage) {
            DispatchQueue.main.async {
                self.hud.stop()
                self.articleViewModel.loadArticlesCache()
                self.tableView.reloadData()
            }
        }
    }
}
// MARK: - Auxiliary Methods
extension ArticlesTableViewController {
    @objc func refreshArticles(){
        articleViewModel.loadArticlesCache()
        tableView.reloadData()
    }
    
    @objc func getFreshData(){
        currentPage = 1
        articleViewModel.getArticles(page: currentPage) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.articleViewModel.loadArticlesCache()
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    
    func getMoreArticles(){
        fetchingMore = true
        currentPage += 1
        articleViewModel.getArticles(page: currentPage) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50 ){
                self.fetchingMore = false
                self.articleViewModel.loadArticlesCache()
                self.tableView.reloadData()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView:UIScrollView) {
      let offsetY = scrollView.contentOffset.y
      let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                getMoreArticles()
            }
        }
    }
}

//MARK: Prepare for Segue
extension ArticlesTableViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Geri"
        navigationItem.backBarButtonItem = backItem
        if let destinationVC = segue.destination as? ArticleContentViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = articleViewModel.articlesCache?[indexPath.row]
                
                guard let content = article else { return }
                
                destinationVC.currentArticle = content
            }
        }
    }
}
//MARK: Article Cell Delegate
extension ArticlesTableViewController: ArticleCellDelegate {
    func didTapBookmark(article: ArticleCache) {
        if article.bookmarked {
            //Set False
            articleViewModel.changeArticleBookmark(article: article, state: false)
            articleViewModel.loadArticlesCache()
            tableView.reloadData()
        } else {
            //Set True
            articleViewModel.changeArticleBookmark(article: article, state: true)
            articleViewModel.loadArticlesCache()
            tableView.reloadData()
        }
    }
}
