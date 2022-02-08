//
//  ArticleTableViewDelegate.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 21.04.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

// MARK: - Table view data source
extension ArticleListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = articleViewModel.articlesCache?[indexPath.row] else { return UITableViewCell() }
              let cell: ArticleCell = tableView.dequeueReusableCell()
        cell.didArticleBookmarked = { [weak self] article in
            self?.didTapBookmark(article: article)
        }
        cell.setArticle(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: UnwindIdentifier.identifier(for: .ArticleContent), sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
                getMoreArticles()
            }
        }
    }
}

extension ArticleListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { categoryViewModel.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = categoryViewModel.category(at: indexPath.row) else { return UICollectionViewCell() }
        let cell: ArticleCategoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select(category: categoryViewModel.category(at: indexPath.row))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 32)
    }
}
