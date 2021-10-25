//
//  PhotoDetailsConfigurator.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import Foundation

protocol PhotoDetailsConfiguratorProtocol: AnyObject {
    func configure(view: PhotoDetailsViewController)
}

class PhotoDetailsConfigurator: PhotoDetailsConfiguratorProtocol {
    
    // MARK: - Public Properties
    
    let photo: Photo?
    
    // MARK: - Initializers
    
    init(photo: Photo?) {
        self.photo = photo
    }
    
    // MARK: - Public Methods
    
    func configure(view: PhotoDetailsViewController) {
        let router = PhotoDetailsRouter(view: view)
        let presenter = PhotoDetailsPresenter(view: view, photo: photo, router: router)
        view.presenter = presenter
    }
}
