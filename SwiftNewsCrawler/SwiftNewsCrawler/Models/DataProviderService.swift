//
//  DataParserService.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation

class DataProviderService {

    var dataFetcher: DataFetchProtocol?

    init(fetcher: DataFetchProtocol) {
        self.dataFetcher = fetcher
    }

    func decodeModelFrom<T: Decodable>(data: Data, type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let typedObject: T? = try decoder.decode(T.self, from: data)
            return typedObject
        } catch {
                print(error.localizedDescription)
        }
        return nil
    }

    func decodeDataFrom<T: Decodable>(urlString: String, type: T.Type, handler: @escaping(T?, Error?) -> Void) {
        self.dataFetcher?.loadDataFrom(urlString: urlString, completionHandler: { (data, error) in
            if let data = data {
                let typedObject: T? = self.decodeModelFrom(data: data, type: type)

                if let object = typedObject {
                    handler(object, nil)
                } else {
                    handler(nil, RequestError.parseError)
                }
            } else {
                print(error?.localizedDescription ?? "")
            }

        })
    }
}
