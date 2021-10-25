//
//  NetworkRequest.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(with completion: @escaping (Result<ModelType, NetworkError>) -> Void)
}

extension NetworkRequest {
    
    func load(_ url: URL, with completion: @escaping (Result<ModelType, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            
            guard error == nil else {
                completion(.failure(.badRequest))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("RESPONSE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let decodedObject = self.decode(data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(decodedObject))
        }
        task.resume()
    }
}
