//
//  ArticleTableViewDelegate.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.04.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

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
        cell.delegate = self
        cell.setArticle(article: article)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToArticleContent", sender: nil)
    }
}
