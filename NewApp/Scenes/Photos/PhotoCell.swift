//
//  PhotoCell.swift
//  NewApp
//
//  Created by Admin on 22.10.2021.
//

import UIKit
import Kingfisher

protocol PhotoCellView {
    func set(image: String?)
}

class PhotoCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppreance()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func configureAppreance() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Reusable, ImageCellView

extension PhotoCell: Reusable, PhotoCellView {
    func set(image: String?) {
        let url = URL(string: image ?? "")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}
