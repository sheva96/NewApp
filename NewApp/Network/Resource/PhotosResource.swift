//
//  RandomImagesResource.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import Foundation

struct PhotosResource {
    var page = 1
}

extension PhotosResource: APIResource {
    typealias ModelType = [Photo]
    
    var path: String {
        "/photos"
    }
    
    var url: URL {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Components could not be configured.")
        }
        
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "client_id", value: accessKey)
        ]
        
        guard let url = components.url else {
            fatalError("URL could not be configured.")
        }
        return url
    }
}

