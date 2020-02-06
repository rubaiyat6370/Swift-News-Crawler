//
//  DetailArticleViewController.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {
    @IBOutlet weak var articleBodyLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbnailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var thumbnailHeightConstraint: NSLayoutConstraint!

    var article: SwiftNews!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = article.title
        self.articleBodyLabel.text = article.description
        
        if article.thumbnail != nil {
            thumbnailHeightConstraint.constant = 140
            
            thumbnailTopConstraint.constant = 10
            self.thumbnail.image = article.thumbnail!
        }
        else {
            self.thumbnailTopConstraint.constant = 0
            self.thumbnailHeightConstraint.constant = 0
        }
    }

}
