//
//  PhotoScrollView.swift
//  NewApp
//
//  Created by Admin on 24.10.2021.
//

import UIKit
import Kingfisher

class PhotoScrollView: UIScrollView {
    
    // MARK: - Public Properties
    
    var imageZoomView: UIImageView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }
    
    // MARK: - Public Methods
    
    func set(urlSting: String?) {
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        
        guard let url = URL(string: urlSting ?? "") else { return }
        
        let resource = ImageResource(downloadURL: url, cacheKey: urlSting)
        KingfisherManager.shared.retrieveImage(with: resource) { [weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.imageZoomView = UIImageView(image: value.image)
                self.addSubview(self.imageZoomView)
                self.configureFor(imageSize: value.image.size)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    func setCurrentMaxMinZoomScale() {
        let boundsSize = bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        
        let minScale = min(xScale, yScale)
        
        var maxScale = CGFloat(1)
        
        if minScale < 0.1 {
            maxScale = 0.3
        }
        
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        
        if minScale >= 0.5 {
            maxScale = max(1, minScale)
        }
        
        minimumZoomScale = minScale
        maximumZoomScale = maxScale
    }
    
    private func configureFor(imageSize: CGSize) {
        contentSize = imageSize
        setCurrentMaxMinZoomScale()
        zoomScale = minimumZoomScale
    }
    
    private func centerImage() {
        let boundsSize = bounds.size
        var frameTocenter = imageZoomView.frame
        
        if frameTocenter.size.width < boundsSize.width {
            frameTocenter.origin.x = (boundsSize.width - frameTocenter.size.width) / 2
        } else {
            frameTocenter.origin.x = 0
        }
        
        if frameTocenter.size.height < boundsSize.height {
            frameTocenter.origin.y = (boundsSize.height - frameTocenter.size.height) / 2
        } else {
            frameTocenter.origin.y = 0
        }
        
        imageZoomView.frame = frameTocenter
    }
}

// MARK: - UIScrollViewDelegate

extension PhotoScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}
