//
//  BookmarksViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This function is setting bookmarked article and video table views in the container view
        self.setupView()
        
        //This is for changing segmented control text color
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    
    func setupView() {
        updateView()
    }
    
    
    static func viewController() -> BookmarksViewController {
         return UIStoryboard.init(name: "Bookmarks", bundle: nil).instantiateViewController(withIdentifier: "bookmarksViewController") as! BookmarksViewController
     }
     
    
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
     
     
     
     private lazy var bookmarkedArticlesController: BookmarkedArticlesTableViewController = {
         // Load Storyboard
         let storyboard = UIStoryboard(name: "Bookmarks", bundle: nil)
         
         // Instantiate View Controller
         var viewController = storyboard.instantiateViewController(withIdentifier: "bookmarkedArticles") as! BookmarkedArticlesTableViewController
         
         // Add View Controller as Child View Controller
         self.add(asChildViewController: viewController)
         
         return viewController
     }()
     
     private lazy var bookmarkedVideosController: BookmarkedVideosTableViewController = {
         // Load Storyboard
         let storyboard = UIStoryboard(name: "Bookmarks", bundle: nil)
         
         // Instantiate View Controller
         var viewController = storyboard.instantiateViewController(withIdentifier: "bookmarkedVideos") as! BookmarkedVideosTableViewController
         
         // Add View Controller as Child View Controller
         self.add(asChildViewController: viewController)
         
         return viewController
     }()
    
}
