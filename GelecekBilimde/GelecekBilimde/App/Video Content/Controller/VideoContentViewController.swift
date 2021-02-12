//
//  VideoContentViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 14.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import WebKit

final class VideoContentViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var currentVideo: VideoCache!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = currentVideo.videoTitle
        loadVideo()
    }
    
    private func loadVideo() {
        let myURL = URL(string: "https://www.youtube.com/embed/\(currentVideo.videoURLId)")
        let youtubeRequest = URLRequest(url: myURL!)
        webView.load(youtubeRequest)
    }
    
    @IBAction private func shareButtonClicked(_ sender: UIBarButtonItem) {
        let videoURL = "https://www.youtube.com/watch?v=\(currentVideo.videoURLId)"
        let activityController = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
