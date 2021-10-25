//
//  PhotoDetailsPresenter.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import Foundation

protocol PhotoDetailsPresenterProtocol: AnyObject {
    init(view: PhotoDetailsViewProtocol, photo: Photo?, router: PhotoDetailsRouterProtocol)
    var imageURL: String? { get }
}

class PhotoDetailsPresenter: PhotoDetailsPresenterProtocol {
    
    // MARK: - Public Properties
    
    var imageURL: String? {
        photo?.urls?.small
    }
    
    let photo: Photo?
    
    weak var view: PhotoDetailsViewProtocol?
    var router: PhotoDetailsRouterProtocol?
    
    // MARK: - Initializers
    
    required init(view: PhotoDetailsViewProtocol, photo: Photo?, router: PhotoDetailsRouterProtocol) {
        self.view = view
        self.photo = photo
        self.router = router
    }
}
