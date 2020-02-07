//
//  RequestError.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-06.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import Foundation

//
// MARK: - Request Error
//
enum RequestError: Error {
    //
    // MARK: - Cases
    //
    case invalidURL
    case parseError
    case requestError
    case invalidPath
}
