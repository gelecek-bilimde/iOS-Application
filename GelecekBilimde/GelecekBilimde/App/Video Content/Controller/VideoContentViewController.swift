//
//  VideoContentViewController.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 14.02.2020.
//  Copyright © 2020 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import WebKit

class VideoContentViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var currentVideo: VideoCache!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentVideo.videoTitle
        loadVideo()
    }
    
    func loadVideo(){
        let myURL = URL(string: "https://www.youtube.com/embed/\(currentVideo.videoURLId)")
        let youtubeRequest = URLRequest(url: myURL!)
        webView.load(youtubeRequest)
    }
    
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
        let videoURL = "https://www.youtube.com/watch?v=\(currentVideo.videoURLId)"
        let activityController = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}
