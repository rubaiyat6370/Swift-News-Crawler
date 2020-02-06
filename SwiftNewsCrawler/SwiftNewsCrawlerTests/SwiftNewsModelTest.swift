//
//  SwiftNewsModelTest.swift
//  SwiftNewsCrawlerTests
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import Foundation
import XCTest
@testable import SwiftNewsCrawler

class SwiftNewsModelTest: XCTestCase {
    let jsonString = """
        {
          "selftext": "What Swift-related projects are you currently working on?",
          "title": "What\\u2019s everyone working on this month? (February 2020)",
          "thumbnail_height": null,
          "thumbnail_width": null,
          "thumbnail": "self",
          "url": "https://www.reddit.com/r/swift/comments/ezersj/whats_everyone_working_on_this_month_february_2020/",

        }
    """

    func testSwiftNewsModel() {
        let decoder = JSONDecoder()
        do {
            let swiftNews = try decoder.decode(SwiftNews.self, from: Data(jsonString.utf8))
            XCTAssertNotNil(swiftNews)

            XCTAssertEqual(swiftNews.title, "What’s everyone working on this month? (February 2020)")
            XCTAssertEqual(swiftNews.description, "What Swift-related projects are you currently working on?")
        } catch {
            XCTFail("Decoding failed")
        }
    }
}
