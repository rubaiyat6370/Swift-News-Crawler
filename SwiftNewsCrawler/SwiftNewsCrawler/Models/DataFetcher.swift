//
//  Network.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation

class DataFetcher: DataFetchProtocol {

    static let shared = DataFetcher()

    func loadDataFrom(urlString: String, completionHandler: @escaping (Data?, Error?)-> Void) {

        guard let url = URL(string: urlString) else {
            completionHandler(nil, RequestError.invalidURL)
            return
        }
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, RequestError.requestError)
                return
            }
            completionHandler(data, nil)
        }
        dataTask.resume()
    }

}
