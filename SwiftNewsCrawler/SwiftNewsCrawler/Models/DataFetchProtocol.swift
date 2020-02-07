//
//  DataProviderProtocol.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation

protocol DataFetchProtocol {
    func loadDataFrom(urlString: String, completionHandler: @escaping (Data?, Error?)-> Void)
}
