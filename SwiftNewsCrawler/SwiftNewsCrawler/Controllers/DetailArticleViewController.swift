//
//  DetailArticleViewController.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var articleBodyLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbnailTopConstraint: HeightConstraint!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var thumbnailHeightConstraint: WidthConstraint!
    @IBOutlet weak var thumbnailWidthConstraint: WidthConstraint!
    @IBOutlet weak var thumbnailLeadingConstraint: WidthConstraint!
    @IBOutlet weak var thumbnailTrailingConstraint: WidthConstraint!
    @IBOutlet weak var bodyLabelTopConstraint: HeightConstraint!
    @IBOutlet weak var bodyLabelBottomConstraint: HeightConstraint!
    //
    // MARK: - Constants & Variables
    //
    var article: SwiftNews!
    private let imageHeightConstant: CGFloat = 140


    private let leadingTrailingConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 15.0
        } else {
            return 25.0
        }
    }()

    private let topBottomConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 12.0
        } else {
            return 20.0
        }
    }()

    private let imageWidthConstant: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 345.0
        } else {
            return 784.0
        }
    }()

    let bodyFontSize: CGFloat = {
          if AppUtils.deviceType == "iPhone" {
              return 13.0
          } else {
              return 20.0
          }
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func setupThumbnail(image: UIImage, height: CGFloat, width: CGFloat) {
        let heightRatio: CGFloat = imageWidthConstant/image.size.width
        thumbnailWidthConstraint.constant = imageWidthConstant
        thumbnailHeightConstraint.constant = image.size.height * heightRatio
        thumbnailTopConstraint.constant = topBottomConstant
        self.thumbnail.image = article.thumbnail!
    }

    fileprivate func removeThumbnail(){
        self.thumbnailTopConstraint.constant = 0
        self.thumbnailHeightConstraint.constant = 0
    }

    fileprivate func setupConstraints() {
        self.thumbnailLeadingConstraint.constant = leadingTrailingConstant
        self.thumbnailTrailingConstraint.constant = leadingTrailingConstant
        self.thumbnailTopConstraint.constant = topBottomConstant
        self.bodyLabelTopConstraint.constant = topBottomConstant
        self.bodyLabelBottomConstraint.constant = topBottomConstant
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = article.title
        self.articleBodyLabel.text = article.description
        self.articleBodyLabel.font = UIFont.systemFont(ofSize: bodyFontSize * Constants.widthConstant)
        setupConstraints()

        // if image is dowloaded
        if article.thumbnail != nil {
            setupThumbnail(image: article.thumbnail!, height: article.thumbnailHeight!, width: article.thumbnailWidth!)
        }
        else {
            // if image url is invalid shows empty image icon
            if article.thumbnailHeight != nil && article.thumbnailWidth != nil {
                setupThumbnail(image: UIImage(named: "imageIcon")!, height: imageHeightConstant, width: imageHeightConstant)
            } else {
                removeThumbnail()
            }

        }
    }

}
