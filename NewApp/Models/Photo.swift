//
//  Image.swift
//  NewApp
//
//  Created by Admin on 21.10.2021.
//

import Foundation

struct Photo: Decodable {
    let id: String?
    let createdAt: String?
    let urls: Urls?
    let likes: Int?
    let user: User?
    let views: Int?
    let downloads: Int?
}

extension Photo {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case urls = "urls"
        case likes = "likes"
        case user = "user"
        case views = "views"
        case downloads = "downloads"
    }
}


