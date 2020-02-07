//
//  NetworkTest.swift
//  SwiftNewsCrawlerTests
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftNewsCrawler

class NetworkTest: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadData() {
//        let expectation = XCTestExpectation(description: "Download JSON data form url")
//        NetworkAPIClient.loadJSONData(urlString: "https://www.reddit.com/r/swift/.json", type: JSONData.self) { (data, error) in
//            XCTAssertNotNil(data, "No data was downloaded.")
//            XCTAssertNil(error)
//            XCTAssertNotNil(data?.data)
//            XCTAssertNotNil(data?.data.children)
//            XCTAssertTrue((data?.data.children.count)! > 0)
//
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 10.0)
    }

    func testDownloadFile() {
//        let expectation = XCTestExpectation(description: "Download file from url")
//
//        NetworkAPIClient.downloadFileFrom(url: "https://a.thumbs.redditmedia.com/HvVm3Koz8I4i0eih81K1wlT2-KoRKizviRDUiF5ugm0.jpg") { (data) in
//            XCTAssertNotNil(data, "No data was downloaded.")
//            XCTAssertNotNil(UIImage(data: data!))
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.5)
    }

   
}
