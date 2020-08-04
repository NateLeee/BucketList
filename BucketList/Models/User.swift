//
//  User.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
