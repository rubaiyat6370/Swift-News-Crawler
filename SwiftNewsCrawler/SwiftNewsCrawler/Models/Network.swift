//
//  Network.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation

class Network {

    static func loadJSONData<T: Decodable>(urlString: String, type: T.Type, completionHandler: @escaping (T?, Error?)-> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let json = data {
                    do {
                        let decoder = JSONDecoder()
                        let typedObject: T? = try decoder.decode(T.self, from: json)
                        completionHandler(typedObject, nil)
                    } catch {
                        print(error.localizedDescription)
                    }

                }
            }
        }
        dataTask.resume()
    }

    static func downloadFileFrom(url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        downloadTask.resume()

    }
}
