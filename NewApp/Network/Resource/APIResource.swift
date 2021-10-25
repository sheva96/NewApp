//
//  APIRequest.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var url: URL { get }
    var path: String { get }
}

extension APIResource {
    var baseURL: String {
        "https://api.unsplash.com"
    }
    
    var accessKey: String? {
        "wm3GNuEyN3sdXtKYGyPPYc0APoLdf5KNndUpyDBRnxM"
    }
}
