//
//  TableViewCell.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var thumbnailHeightConstraint: WidthConstraint!
    
    @IBOutlet weak var headlineLeadingConstraint: WidthConstraint!
    @IBOutlet weak var headlineTopConstraint: HeightConstraint!
    
    @IBOutlet weak var headlineTrailingConstraint: WidthConstraint!
    @IBOutlet weak var thumbnailWidthConstraint: WidthConstraint!
    @IBOutlet weak var thumbnailBottomConstraint: HeightConstraint!
    @IBOutlet weak var thumbnailTopConstraint: HeightConstraint!
    //
    // MARK: - Constants & Variables
    //
    let thumbnailHeightConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 83.0
        } else {
            return 120
        }
    }()

    let topBottomConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 7.0
        } else {
            return 12.0
        }
    }()

    let leadingTrailingConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 15
        } else {
            return 22
        }
    }()

    let headlineFontSize: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 13.0
        } else {
            return 20.0
        }
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
    }
    
    fileprivate func setupThumbnail(image: UIImage, height: CGFloat, width: CGFloat) {
        thumbnailHeightConstraint.constant = thumbnailHeightConstant
        let widthRatio: CGFloat = thumbnailHeightConstant/height
        thumbnailWidthConstraint.constant = width * widthRatio
        thumbnailBottomConstraint.constant = topBottomConstant
        self.thumbnail.image = image
    }

    fileprivate func removeThumbnail() {
        self.thumbnailBottomConstraint.constant = 0
        self.thumbnailHeightConstraint.constant = 0
    }

    fileprivate func setupConstraints() {
        self.headlineLabel.font = UIFont.systemFont(ofSize: headlineFontSize * Constants.widthConstant)
        self.headlineLeadingConstraint.constant = leadingTrailingConstant
        self.headlineTrailingConstraint.constant = leadingTrailingConstant
        self.thumbnailTopConstraint.constant = topBottomConstant
        self.headlineTopConstraint.constant = topBottomConstant
        self.thumbnailBottomConstraint.constant = topBottomConstant
    }

    fileprivate func downloadImage(_ news: SwiftNews) {
        DataFetcher.shared.loadDataFrom(urlString: news.thumbnailURL!) { (data, _) in
            if data != nil {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        self.setupThumbnail(image: image, height: news.thumbnailHeight!, width: news.thumbnailWidth!)
                    }

                }
            }
        }
    }

    func setupCell(news: SwiftNews) {
        setupConstraints()
        self.headlineLabel.text = news.title
        if news.thumbnail != nil {
            setupThumbnail(image: news.thumbnail!, height: news.thumbnailHeight!, width: news.thumbnailWidth!)
        }
        else {
            if news.thumbnailHeight != nil && news.thumbnailWidth != nil {
                setupThumbnail(image: UIImage(named: "imageIcon")!, height: thumbnailHeightConstant, width: thumbnailHeightConstant)
                downloadImage(news)
            } else {
                removeThumbnail()
            }
        }
    }
    
}
