//
//  Result.swift
//  BucketList
//
//  Created by Nate Lee on 8/6/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
