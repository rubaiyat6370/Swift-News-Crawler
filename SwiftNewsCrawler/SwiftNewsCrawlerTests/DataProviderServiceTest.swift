//
//  DataProviderServiceTest.swift
//  SwiftNewsCrawlerTests
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-07.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftNewsCrawler

class DataProviderServiceTest: XCTestCase {
    var provider: DataProviderService! = nil

    override func setUp() {
        provider = DataProviderService(fetcher: MockDataFetcher())
        continueAfterFailure = false
    }
    func testDataLoader() {
        let expectation = XCTestExpectation(description: "Download JSON data form url")
        provider.decodeDataFrom(urlString: "https://www.reddit.com/r/swift/.json", type: JSONData.self) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertNotNil(data?.data)
            XCTAssertNotNil(data?.data.children)
            XCTAssertTrue((data?.data.children.count)! > 0)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
