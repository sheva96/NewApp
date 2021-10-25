//
//  PhotosConfigurator.swift
//  NewApp
//
//  Created by Admin on 21.10.2021.
//

import UIKit

protocol PhotosConfiguratorProtocol {
    func configure(view: PhotosViewController)
}

class PhotosConfigurator: PhotosConfiguratorProtocol {
    
    // MARK: - Public Methods
    
    func configure(view: PhotosViewController) {
//        let resource = RandomImagesResource()
//        let request = APIRequest(resource: resource)
        let router = PhotosRouter(view: view)
        view.presenter = PhotosPresenter(view: view, router: router)
    }
}
