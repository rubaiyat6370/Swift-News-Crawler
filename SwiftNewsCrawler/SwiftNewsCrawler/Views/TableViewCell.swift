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

    let thumbnailHeightConstant: CGFloat = 80.0
    let thumbnailBottomConstant: CGFloat = 10.0

    @IBOutlet weak var thumbnailTopConstraint: HeightConstraint!
    
    fileprivate func setupThumbnail(image: UIImage, height: CGFloat, width: CGFloat) {
        thumbnailHeightConstraint.constant = thumbnailHeightConstant * Constants.heightConstant
        let widthRatio: CGFloat = thumbnailHeightConstant/height
        thumbnailWidthConstraint.constant = width * widthRatio * Constants.widthConstant
        thumbnailBottomConstraint.constant = thumbnailBottomConstant * Constants.heightConstant
        //self.thumbnailTopConstraint.constant = thumbnailBottomConstant * Constants.heightConstant
        self.thumbnail.image = image
    }

    func setupCell(news: SwiftNews) {
        self.headlineLabel.text = news.title
        if news.thumbnail != nil {
            setupThumbnail(image: news.thumbnail!, height: news.thumbnailHeight!, width: news.thumbnailWidth!)
        }
        else {
            if news.thumbnailHeight != nil || news.thumbnailWidth != nil {
                setupThumbnail(image: UIImage(named: "imageIcon")!, height: 80.0, width: 80.0)
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
                //self.thumbnailTopConstraint.constant = 0
            }
        }
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
