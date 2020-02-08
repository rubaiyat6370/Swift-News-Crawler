//
//  MockAPIClient.swift
//  SwiftNewsCrawlerTests
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation
@testable import SwiftNewsCrawler

class MockDataFetcher: DataFetchProtocol {

    let testBundle: Bundle
    init() {
        testBundle = Bundle(for: type(of: self))
    }
    func loadDataFrom(urlString: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard URL(string: urlString) != nil else {
            completionHandler(nil, RequestError.invalidURL)
            return
        }

        if let path = testBundle.path(forResource: "RedditDummyPosts", ofType: "json", inDirectory: "Resources") {
            do {
                let string = try String(contentsOfFile: path, encoding: .utf8)
                if let data = string.data(using: .utf8) {
                    completionHandler(data, nil)
                } else {
                    completionHandler(nil, RequestError.parseError)
                }

            } catch {
                completionHandler(nil, RequestError.parseError)
            }
            
        }

    }

    func readDataFromFile(name: String, type: String, directory: String) -> Data? {

        if let path = testBundle.path(forResource: name, ofType: type, inDirectory: directory) {
            do {
                let string = try String(contentsOfFile: path, encoding: .utf8)
                if let data = string.data(using: .utf8) {
                    return data
                } else {
                    return nil
                }

            } catch {
                return nil
            }
        }
        return nil
    }
}

