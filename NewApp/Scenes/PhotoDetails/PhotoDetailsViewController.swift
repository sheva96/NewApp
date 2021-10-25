//
//  PhotoDetailsViewController.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import UIKit
import Kingfisher

protocol PhotoDetailsViewProtocol: AnyObject {}

class PhotoDetailsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: PhotoDetailsPresenterProtocol?
    var configurator: PhotoDetailsConfiguratorProtocol? {
        didSet {
            configurator?.configure(view: self)
        }
    }
    
    // MARK: - Private Properties
    
    var imageScrollView: PhotoScrollView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        setupImageView()
        imageScrollView.set(urlSting: presenter?.imageURL)
    }
    
    // MARK: - Private Methods

    private func setupImageView() {
        imageScrollView = PhotoScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotoDetailsViewController: PhotoDetailsViewProtocol {}
