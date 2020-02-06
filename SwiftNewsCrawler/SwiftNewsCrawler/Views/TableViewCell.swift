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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(news: SwiftNews) {
        self.headlineLabel.text = news.title
        if news.thumbnail != nil {
            thumbnailHeightConstraint.constant = 80
            thumbnailBottomConstraint.constant = 8
            self.thumbnail.image = news.thumbnail!
            self.thumbnail.isHidden = false
        }
        else {
            self.thumbnail.isHidden = true
            self.thumbnailBottomConstraint.constant = 0
            self.thumbnailHeightConstraint.constant = 0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
