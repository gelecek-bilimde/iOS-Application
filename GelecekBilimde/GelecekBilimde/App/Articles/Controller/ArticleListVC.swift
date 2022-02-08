//
//  ArticleListVC.swift
//  GelecekBilimde
//
//  Created by BARIS UYAR on 6.02.2021.
//  Copyright © 2021 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class ArticleListVC: UIViewController {
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.register(ArticleCategoryCell.self)
        }
    }
    @IBOutlet private weak var articleTableView: UITableView! {
        didSet {
            articleTableView.register(ArticleCell.self)
            articleTableView.delegate = self
            articleTableView.dataSource = self
            articleTableView.separatorStyle = .none
        }
    }
    
    var articleViewModel: ArticleViewModel!
    var categoryViewModel: CategoryViewModel!
    private let hud = CustomProgressHUD()
    var fetchingMore = false
    var datePicker: UIDatePicker!
    var transparentView: UIView!
    var toolBar = UIToolbar()
    var emptyMessage: String = "Seçtiğiniz kriterlere uygun henüz bir makale yayımlamadık :("
    var selectedDate: Date? {
        didSet {
            if selectedDate != oldValue {
                articleViewModel.selectedCategory?.page = 1
                articleViewModel.currentpage = 1
                select(category: articleViewModel.selectedCategory)
            }
        }
    }
    private lazy var emptyMessageView: EmptyStateView = {
        return EmptyStateView(frame: articleTableView.frame, message: emptyMessage)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshArticles), name: NSNotification.Name(rawValue: "articleBookmarkChangeFromBookmark"), object: nil)
        categoryViewModel = CategoryViewModel()
        articleViewModel = ArticleViewModel()
        cached()
        articleTableView.backgroundColor = .white
        let image = UIImage(named: "calendar")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(didTapCalendar(_:)))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.categoryCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func select(category: ArticleCategory? = nil) {
        hud.play(view: view)
        articleViewModel.didSelect(category: category, date: selectedDate) { [weak self] in
            guard let self = self else { return }
            self.hud.stop()
            self.cached()
        }
    }
    
    private func cached() {
        articleViewModel.loadArticlesCache()
        articleTableView.reloadData()
    }
    
    func didTapBookmark(article: ArticleCache) {
       articleViewModel.changeArticleBookmark(article: article, state: !article.bookmarked)
        articleViewModel.loadArticlesCache()
        articleTableView.reloadData()
    }
    
    @objc private func refreshArticles() {
        cached()
    }
    
    @objc private func didTapCalendar(_ sender: UIBarButtonItem) {
        transparentView = .init(frame: view.frame)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let datePickerContainerView = UIView(frame: CGRect(x: 0, y: (transparentView.frame.maxY - 250) / 2 , width: view.bounds.width, height: 250.0))
        datePickerContainerView.backgroundColor = .white
        
        transparentView.addSubview(datePickerContainerView)
        
        datePicker = UIDatePicker()
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 250.0)
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.center = datePickerContainerView.center
        datePicker.maximumDate = Date()
        datePicker.setDate(selectedDate ?? Date(), animated: false)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainerView.addSubview(datePicker)
        NSLayoutConstraint.activate([
                                        datePicker.topAnchor.constraint(equalTo: datePickerContainerView.topAnchor),
                                        datePicker.bottomAnchor.constraint(equalTo: datePickerContainerView.bottomAnchor),
                                        datePicker.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor),
                                        datePicker.trailingAnchor.constraint(equalTo: datePickerContainerView.trailingAnchor)])
        
        toolBar.frame = CGRect(x: 0, y: datePickerContainerView.frame.minY - 50, width: view.bounds.width, height: 50)
        toolBar.backgroundColor = .white
        toolBar.tintColor = .darkGray
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tarihi Seç", style: .plain, target: self, action: #selector(dateChoosed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Temizle", style: .plain, target: self, action: #selector(dateClean))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        transparentView.addSubview(toolBar)
        view.addSubview(transparentView)
    }
    
    @objc private func dateClean() {
        selectedDate = nil
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        transparentView.removeFromSuperview()
    }
    
    @objc private func dateChoosed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'00:00:00"
        let a = dateFormatter.string(from:  datePicker.date)
        selectedDate = dateFormatter.date(from: a)
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        transparentView.removeFromSuperview()
    }
    
    func getMoreArticles() {
        fetchingMore = true
        articleViewModel.getArticles() { [weak self] in
            guard let self = self else { return }
            self.fetchingMore = false
            self.articleViewModel.loadArticlesCache()
            self.articleTableView.reloadData()
        }
    }
    
    func numberOfRows() -> Int {
        guard let articles = articleViewModel.articlesCache, !articles.isEmpty else {
            articleTableView.backgroundView = emptyMessageView
            return 0
        }
        articleTableView.backgroundView = nil
        return articles.count
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if let destinationVC = segue.destination as? ArticleContentViewController {
            if let indexPath = articleTableView.indexPathForSelectedRow {
                let article = articleViewModel.articlesCache?[indexPath.row]
                guard let content = article else { return }
                destinationVC.currentArticle = content
            }
        }
    }
}
