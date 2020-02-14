//
//  ArticlesTableViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    var currentPage = 1
    var articleViewModel: ArticleViewModel!
    var fetchingMore = false
    let hud = CustomProgressHUD()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(getFreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleViewModel = ArticleViewModel()
        articleViewModel.loadArticlesCache()
        //This is for setting table view's background color
        self.tableView.backgroundColor = UIColor.tableViewBgColor
        self.tableView.refreshControl = refresher
        articleViewModel.getArticles(page: currentPage) {
            DispatchQueue.main.async {
                self.articleViewModel.loadArticlesCache()
                self.tableView.reloadData()
            }
        }
    }
}
// MARK: - Auxiliary Methods
extension ArticlesTableViewController {
    
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

// MARK: - Table view data source
extension ArticlesTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.articlesCache?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentArticle = articleViewModel.articlesCache?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        guard let article = currentArticle else { return UITableViewCell() }
        cell.setArticle(article: article)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToArticleContent", sender: nil)
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
