//
//  SwiftNews.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import UIKit

class SwiftNews: Decodable {

    let title: String
    let description: String
    let url: String
    let thumbnailURL: String?
    let thumbnailHeight: CGFloat?
    let thumbnailWidth: CGFloat?
    var thumbnail: UIImage?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "selftext"
        case url = "url"
        case thumbnailURL = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }

    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        thumbnailWidth = try container.decodeIfPresent(CGFloat.self, forKey: .thumbnailWidth)
        thumbnailHeight = try container.decodeIfPresent(CGFloat.self, forKey: .thumbnailHeight)
        if thumbnailWidth == nil || thumbnailHeight == nil {
            self.thumbnail = nil
        } else {
            guard let url = thumbnailURL else { return }
            DataFetcher.shared.loadDataFrom(urlString: url) { [weak self](imageData, _) in
                guard let data = imageData else {
                    self?.thumbnail = nil
                    return
                }
                self?.thumbnail = UIImage(data: data)
            }
        }
    }

}

struct ChildPost: Decodable {
    let data: SwiftNews
}

struct ChildData: Decodable {
    let children: [ChildPost]
}

struct JSONData: Decodable {
    let data: ChildData
}
