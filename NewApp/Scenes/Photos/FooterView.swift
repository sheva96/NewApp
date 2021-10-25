//
//  FooterView.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import UIKit

class FooterView: UICollectionReusableView, Reusable {
    
    // MARK: - Public Properties

    let activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        activityIndicatorView.color = .lightGray
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
