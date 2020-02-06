//
//  SwiftNews.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import UIKit

struct SwiftNews: Decodable {

    let title: String
    let description: String
    let url: String
    let thumbnail: String?
    let thumbnailHeight: CGFloat?
    let thumbnailWidth: CGFloat?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "selftext"
        case url = "url"
        case thumbnail = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        thumbnailWidth = try container.decodeIfPresent(CGFloat.self, forKey: .thumbnailWidth)
        thumbnailHeight = try container.decodeIfPresent(CGFloat.self, forKey: .thumbnailHeight)
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

    static func fromJSON(data: Data) -> JSONData? {
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(JSONData.self, from: data)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

}
