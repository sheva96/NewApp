//
//  PhotosPresenter.swift
//  NewApp
//
//  Created by Admin on 21.10.2021.
//

import Foundation

protocol PhotosPresenterProtocol: AnyObject {
    init(view: PhotosViewProtocol, router: PhotosRouterProtocol)
    var numberOfBooks: Int { get }
    var footerViewHeight: Int { get }
    func willDisplayRefreshControl()
    func willDisplayFooterView()
    func didSelect(item: Int)
    func configure(cell: PhotoCellView, for item: Int)
}

class PhotosPresenter: PhotosPresenterProtocol {
    
    // MARK: - Public Properties
    
    var numberOfBooks: Int {
        images.count
    }
    
    var footerViewHeight: Int {
        isLastPageReached ? 0 : 50
    }
    
    weak var view: PhotosViewProtocol?
    let router: PhotosRouterProtocol?
    
    // MARK: - Private Properties
    private var images = [Photo]()
    private var isLastPageReached = false
    private var page = 1
    
    // MARK: - Initializers
    
    required init(view: PhotosViewProtocol, router: PhotosRouterProtocol) {
        self.view = view
        self.router = router
    }

    // MARK: - Public Methods
    
    func willDisplayRefreshControl() {
        fetchImages()
    }
    
    func willDisplayFooterView() {
        fetchImages()
    }
    
    func didSelect(item: Int) {
        let image = images[item]
        router?.pushToImageDetail(photo: image)
    }
    
    func configure(cell: PhotoCellView, for item: Int) {
        let image = images[item]
        cell.set(image: image.urls?.small)
    }
    
    // MARK: - Private Methods
    
    private func fetchImages() {
        let resource = PhotosResource(page: page)
        let request = APIRequest(resource: resource)
        request.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.images += photos
                    self?.page += 1
                case .failure(let error):
                    self?.isLastPageReached = true
                    self?.router?.showError(message: error.description)
                }
                self?.view?.endRefreshing()
                self?.view?.reloadData()
            }
        }
    }
}
