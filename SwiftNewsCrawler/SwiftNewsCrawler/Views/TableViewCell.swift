//
//  TableViewCell.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var thumbnailHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnailWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var thumbnailBottomConstraint: NSLayoutConstraint!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

    fileprivate func setupThumbnail(image: UIImage) {
        thumbnailHeightConstraint.constant = 80
        thumbnailBottomConstraint.constant = 8
        self.thumbnail.image = image
    }

    func setupCell(news: SwiftNews) {
        self.headlineLabel.text = news.title
        if news.thumbnail != nil {
            setupThumbnail(image: news.thumbnail!)
        }
        else {
            if news.thumbnailHeight != nil || news.thumbnailWidth != nil {
                setupThumbnail(image: UIImage(named: "imageIcon")!)
                Network.downloadFileFrom(url: news.thumbnailURL!) { (data) in
                    if data != nil {
                        DispatchQueue.main.async {
                            self.thumbnail.image = UIImage(data: data!)
                        }
                    }
                }
            } else {
                self.thumbnailBottomConstraint.constant = 0
                self.thumbnailHeightConstraint.constant = 0
                print(self.thumbnail.frame.size)
            }
        }
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
