//
//  APIRequest.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import Foundation

class APIRequest<Resource: APIResource> {
    
    // MARK: - Public Properties
    
    let resource: Resource
    
    // MARK: - Initializers

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        guard let images = try? decoder.decode(Resource.ModelType.self, from: data) else {
            return nil
        }
        return images
    }

    func execute(with completion: @escaping (Result<Resource.ModelType, NetworkError>) -> Void) {
        load(resource.url, with: completion)
    }
}
