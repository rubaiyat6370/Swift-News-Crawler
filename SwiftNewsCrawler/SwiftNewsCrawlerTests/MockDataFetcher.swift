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

    func loadDataFrom(urlString: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard URL(string: urlString) != nil else {
            completionHandler(nil, RequestError.invalidURL)
            return
        }

        let testBundle = Bundle(for: type(of: self))

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
}

// "[{\"form_id\":3465,\"canonical_name\":\"df_SAWERQ\",\"form_name\":\"Activity 4 with Images\",\"form_desc\":null}]"
struct testModel: Decodable {
    let form_id: Int
    let canonical_name: String
    let form_name: String
    let form_desc: String?
}
