//
//  NetworkError.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case noData
    case decodingError
}

extension NetworkError  {
    var description: String {
        switch self {
        case .noData:
            return "Failed to get data."
        case .badRequest:
            return "Request failed."
        case .decodingError:
            return "Data decoding error."
        }
    }
}
