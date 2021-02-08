//
//  BookmarksViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

final class BookmarksViewController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private lazy var bookmarkedArticlesController: BookmarkedArticlesTableViewController = {
        let viewController = Destination().BookmarkedArticles
        add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var bookmarkedVideosController: BookmarkedVideosTableViewController = {
        let viewController = Destination().BookmarkedVideos
        add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupView()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .barTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

// MARK: - Actions
extension BookmarksViewController {
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
}

// MARK: - Auxiliary Methods
extension BookmarksViewController {

    // Public Methods
    static func viewController() -> BookmarksViewController {
        return Destination().Bookmarks
    }
    
    func setupView() {
        updateView()
    }
    
    // Private Methods
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: bookmarkedVideosController)
            add(asChildViewController: bookmarkedArticlesController)
        } else {
            remove(asChildViewController: bookmarkedArticlesController)
            add(asChildViewController: bookmarkedVideosController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    //----------------------------------------------------------------
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}
