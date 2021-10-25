//
//  User.swift
//  NewApp
//
//  Created by Admin on 23.10.2021.
//

import Foundation

struct User: Decodable {
    let userName: String?
}

extension User {
    enum CodingKeys: String, CodingKey {
        case userName = "userame"
    }
}
