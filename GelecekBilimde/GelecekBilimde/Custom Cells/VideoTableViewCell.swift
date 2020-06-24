//
//  VideoTableViewCell.swift
//  GelecekBilimde
//
//  Created by Alperen Ünal on 22.09.2019.
//  Copyright © 2019 Burak Furkan Asilturk. All rights reserved.
//

import UIKit
import SDWebImage

final class VideoTableViewCell: UITableViewCell {

    @IBOutlet private weak var videoThumbnailImageView: UIImageView!
    @IBOutlet private weak var videoBookmarkImageView: UIImageView!
    @IBOutlet private weak var videoTitleLabel: UILabel!
    @IBOutlet private weak var videoDateLabel: UILabel!
    
    private var currentVideo: VideoCache!
    var didVideoBookmarked: ((VideoCache) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(bookmarkClicked))
        videoBookmarkImageView.isUserInteractionEnabled = true
        videoBookmarkImageView.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoThumbnailImageView.layer.cornerRadius = 15.0
        videoThumbnailImageView.clipsToBounds = true
    }
    
    @objc private func bookmarkClicked() {
        UIView.animate(withDuration: 0.2, delay: 0,  options: [], animations: {
            self.videoBookmarkImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            DispatchQueue.main.async {
                self.videoBookmarkImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }) { (finished) in
            self.didVideoBookmarked?(self.currentVideo)
        }
    }
    
    func setVideo(videoCache: VideoCache) {
        currentVideo = videoCache
        videoThumbnailImageView.contentMode = .scaleAspectFill
        let dateComponent = findDateFromString(videoCache.videoDate)
        
        videoTitleLabel.text = videoCache.videoTitle
        videoDateLabel.text = "\(String(describing: dateComponent.day!))/\(String(describing: dateComponent.month!))/\(String(describing: dateComponent.year!))"
        videoBookmarkImageView.image = UIImage(named: videoCache.bookmarked ? "bookmarked" : "unbookmarked")
        guard let url = URL(string: videoCache.videoImageURL) else { return }
        videoThumbnailImageView.sd_setImage(with: url) { [weak self] (image, error, cache, urls) in
            self?.videoThumbnailImageView.image = (error != nil) ? UIImage(named: "youtubePlaceHolder") : image
        }
    }
    
    func findDateFromString(_ dateString: String) -> DateComponents {
        
        let dateFormatter = DateFormatter()
        let last4StringOfDate = String(dateString.suffix(4))
        dateFormatter.dateFormat = last4StringOfDate == "000Z" ? "yyyy-MM-dd'T'HH:mm:ss.SSSZ" : "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let calender = Calendar.current
        guard let date = dateFormatter.date(from: dateString) else { return calender.dateComponents([.year, .month, .day], from: Date()) }
        let dateComponent = calender.dateComponents([.year, .month, .day], from: date)
        return dateComponent
    }
    
}
