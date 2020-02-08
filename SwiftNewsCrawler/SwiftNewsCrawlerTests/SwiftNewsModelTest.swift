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
    let swiftNewsJson = """
        {
          "selftext": "What Swift-related projects are you currently working on?",
          "title": "What\\u2019s everyone working on this month? (February 2020)",
          "thumbnail_height": null,
          "thumbnail_width": null,
          "thumbnail": "self",
          "url": "https://www.reddit.com/r/swift/comments/ezersj/whats_everyone_working_on_this_month_february_2020/",

        }
    """
    override func setUp() {
        continueAfterFailure = false
    }

    func testSwiftNewsModel() {
        let decoder = JSONDecoder()
        do {
            let swiftNews = try decoder.decode(SwiftNews.self, from: Data(swiftNewsJson.utf8))
            XCTAssertNotNil(swiftNews)

            XCTAssertEqual(swiftNews.title, "What’s everyone working on this month? (February 2020)")
            XCTAssertEqual(swiftNews.description, "What Swift-related projects are you currently working on?")
        } catch {
            XCTFail("Decoding failed")
        }
    }

    func testJSONDataModel(){
        if let data = MockDataFetcher().readDataFromFile(name: "DummyPosts2", type: "json", directory: "Resources") {
            let decoder = JSONDecoder()

            do {
                let jsonData = try decoder.decode(JSONData.self, from: data)
                XCTAssertNotNil(jsonData)
                XCTAssertNotNil(jsonData.data)
                XCTAssertNotNil(jsonData.data?.children)
            } catch {
                XCTFail()
            }

        }
    }

    func testJSONDataInvalidModel(){
        if let data = MockDataFetcher().readDataFromFile(name: "DummyPosts5", type: "json", directory: "Resources") {
            let decoder = JSONDecoder()

            do {
                let jsonData = try decoder.decode(JSONData.self, from: data)
                XCTAssertNotNil(jsonData)
                XCTAssertNil(jsonData.data)
            } catch {
                XCTFail()
            }

        }
    }

    func testChildDataModel(){
        if let data = MockDataFetcher().readDataFromFile(name: "DummyPosts3", type: "json", directory: "Resources") {
            let decoder = JSONDecoder()

            do {
                let jsonData = try decoder.decode(ChildData.self, from: data)
                XCTAssertNotNil(jsonData)
                XCTAssertNotNil(jsonData.children)
                XCTAssertTrue(jsonData.children!.count > 0)
            } catch {
                XCTFail()
            }

        }
    }

    func testChildPostModel(){
        if let data = MockDataFetcher().readDataFromFile(name: "DummyPosts4", type: "json", directory: "Resources") {
            let decoder = JSONDecoder()

            do {
                let jsonData = try decoder.decode(ChildPost.self, from: data)
                XCTAssertNotNil(jsonData)
            } catch {
                XCTFail()
            }

        }
    }
}
