//
//  ArticleCell.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 5.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class ArticleCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet private weak var articleBookmarkButton: UIButton!
    @IBOutlet private weak var articleMainImageView: UIImageView!
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleDescriptionLabel: UILabel!
    @IBOutlet private weak var articleAddedDateLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    private var currentArticle: ArticleCache!
    var didArticleBookmarked: ((ArticleCache) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        let tap = UITapGestureRecognizer(target: self, action: #selector(bookmarkClicked))
        articleBookmarkButton.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articleMainImageView.layer.cornerRadius = 20
        articleMainImageView.clipsToBounds = true
        articleMainImageView.contentMode = .scaleAspectFill
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOffset = .zero
        containerView.layer.cornerRadius = 10
    }
    
    func setArticle(article: ArticleCache) {
        currentArticle = article
        articleMainImageView.image = UIImage(named: "GelecekBilimdeLogo")
        articleTitleLabel.text = article.title.convertHTMLEntities()
        articleDescriptionLabel.text = article.excrpt.cleanString()
        articleAddedDateLabel.text = article.date.gbComponent()
        let image = UIImage(named: article.bookmarked ? "bookmarked" : "unbookmarked")?.withRenderingMode(.alwaysTemplate)
        articleBookmarkButton.setImage(image, for: .normal)
        articleBookmarkButton.tintColor = .gray
        guard let url = URL(string: article.imageURL) else { return }
        articleMainImageView.sd_setImage(with: url) { [weak self] (image, error, cache, urls) in
            self?.articleMainImageView.image = (error != nil) ? UIImage(named: "GelecekBilimdeLogo") : image
        }
    }
    
    func cleanString(from text: String) -> String {
        let cleanString = text.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return cleanString
    }
    
    @objc func bookmarkClicked() {
        UIView.animate(withDuration: 0.2, delay: 0,  options: [], animations: {
            self.articleBookmarkButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            DispatchQueue.main.async {
                self.articleBookmarkButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }) { (finished) in
            self.didArticleBookmarked?(self.currentArticle)
        }
    }
}

