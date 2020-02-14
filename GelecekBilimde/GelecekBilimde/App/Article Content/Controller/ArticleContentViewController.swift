//
//  ArticleContentViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 13.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import WebKit

class ArticleContentViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var webView: WKWebView!
    var currentArticle: ArticleCache!
    var hud: CustomProgressHUD!
    
    override func loadView() {
        webView = WKWebView()
        webView.backgroundColor = UIColor.tableViewBgColor
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentArticle.title
        hud = CustomProgressHUD()
        loadHTML()
    }
    
    func loadHTML(){
        hud.play(view: view)
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial scale=1">
        <style> p { color: white; } figcaption { color: white; } img { height: 200; width: 300; } a { color: white; }
        li { color: white; } h1 { color: white; } h2 { color: white; } h3 { color: white; } h4 { color: white; }
        </style>
        </head>
        <body style="background-color:#0B3762;">
        \(currentArticle.content)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        hud.stop()
    }
    
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: [currentArticle.link], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}
