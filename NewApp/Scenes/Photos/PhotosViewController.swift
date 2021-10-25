//
//  PhotosViewController.swift
//  NewApp
//
//  Created by Admin on 21.10.2021.
//

import UIKit

protocol PhotosViewProtocol: AnyObject {
    func reloadData()
    func endRefreshing()
}

class PhotosViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var presenter: PhotosPresenterProtocol?
    
    var configurator: PhotosConfiguratorProtocol? {
        didSet {
            configurator?.configure(view: self)
        }
    }
    
    // MARK: - Private Properties
    
    private let refreshControl = UIRefreshControl()
    private var collectionView: UICollectionView!
    
    private var elementKind: String {
        UICollectionView.elementKindSectionFooter
    }
    
    private var inset: CGFloat {
        view.layoutMargins.left
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        presenter?.viewDidLoad()
        configureNavigatinBar()
        setupCollectionView()
    }
    
    // MARK: - Private Methods
    
    @objc
    private func refreshControlAction() {
        presenter?.willDisplayRefreshControl()
    }
    
    private func configureNavigatinBar() {
        navigationItem.title = "Photos"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: PhotoCell.self)
        collectionView.register(supplementaryViewType: FooterView.self, ofKind: elementKind)

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: - ImagesViewProtocol

extension PhotosViewController: PhotosViewProtocol {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfBooks ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotoCell.self)
        presenter?.configure(cell: cell, for: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, for: indexPath, viewType: FooterView.self
        )
    }
}


// MARK: - UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(item: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let value = (collectionView.bounds.width / 3) - inset
        return CGSize(width: value, height: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height = CGFloat(presenter?.footerViewHeight ?? 0)
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController {
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let footerView = view as? FooterView else { return }
        footerView.activityIndicatorView.startAnimating()
        presenter?.willDisplayFooterView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        guard let footerView = view as? FooterView else { return }
        footerView.activityIndicatorView.stopAnimating()
    }
}

