//
//  PhotosRouter.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import UIKit


protocol PhotosRouterProtocol {
    func pushToImageDetail(photo: Photo)
    func showError(message: String)
}

class PhotosRouter: PhotosRouterProtocol {
    
    // MARK: - Public Properties
    
    weak var view: PhotosViewController?
    var photo: Photo?
    
    // MARK: - Initializers
    
    init(view: PhotosViewController) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func pushToImageDetail(photo: Photo) {
        let imageDetailVC = PhotoDetailsViewController()
        imageDetailVC.configurator = PhotoDetailsConfigurator(photo: photo)
        view?.navigationController?.pushViewController(imageDetailVC, animated: true)
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        view?.present(alertController, animated: true)
    }
}
