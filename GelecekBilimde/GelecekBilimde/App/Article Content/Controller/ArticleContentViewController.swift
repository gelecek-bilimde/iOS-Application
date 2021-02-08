//
//  ArticleContentViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import WebKit

final class ArticleContentViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = currentArticle.title.convertHTMLEntities()
        }
    }
    @IBOutlet private var webView: WKWebView!
    private var hud: CustomProgressHUD!
    var currentArticle: ArticleCache!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.backgroundColor = .white
        webView.scrollView.showsVerticalScrollIndicator = false
        hud = CustomProgressHUD()
        loadHTML()
    }
    
    private func loadHTML() {
        hud.play(view: view)
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial scale=1">
        <style> p { color: black; } figcaption { color: black; } img { height: 200; width: 300; } a { color: black; }
        li { color: black; } h1 { color: black; } h2 { color: black; } h3 { color: black; } h4 { color: black; }
        </style>
        </head>
        <body style="background-color: white;font-family:Arial">
        \(currentArticle.content)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        hud.stop()
    }
    
    @IBAction private func shareButtonTapped(_ sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: [currentArticle.link], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}
