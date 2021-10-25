//
//  PhotoDetailsRouter.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import Foundation

protocol PhotoDetailsRouterProtocol {
    func popViewController()
}

class PhotoDetailsRouter: PhotoDetailsRouterProtocol {
    
    // MARK: - Public Properties
    
    let view: PhotoDetailsViewController?
    
    // MARK: - Initializers
    
    init(view: PhotoDetailsViewController) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
}
