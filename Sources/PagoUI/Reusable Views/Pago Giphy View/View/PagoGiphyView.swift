//
//  
//  PagoGiphyView.swift
//  Pago
//
//  Created by Gabi Chiosa on 16.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import UIKit
import GiphyUISDK

@available(iOS 13.0, *)
class PagoGiphyView: BaseView {
    
    private var contentView: PagoView!
    private var animationView: GPHMediaView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var viewPresenter: PagoGiphyPresenter { return (presenter as! PagoGiphyPresenter) }
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        return tapRecognizer
    }()
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    init(presenter: PagoGiphyPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoGiphyPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        loadData()
        presenter.loadData()
    }

    private func loadData() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView = PagoView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewPresenter.style.inset.left).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewPresenter.style.inset.right).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: viewPresenter.style.inset.top).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -viewPresenter.style.inset.bottom).isActive = true
        
        animationView = GPHMediaView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(animationView)
        
        animationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        if let size = viewPresenter.style.size {
            let width = animationView.widthAnchor.constraint(equalToConstant: size.width)
            width.isActive = true
            widthConstraint = width
            let height = animationView.heightAnchor.constraint(equalToConstant: size.height)
            height.isActive = true
            heightConstraint = height
        }

        animationView.isAccessibilityElement = false
        isAccessibilityElement = viewPresenter.accessibility.isAccessibilityElement
        accessibilityTraits = viewPresenter.accessibility.accessibilityTraits
        accessibilityLabel = viewPresenter.accessibility.accessibilityLabel
        
        if let radius = viewPresenter.style.cornerRadius {
            contentView.layer.cornerRadius = CGFloat(radius)
            contentView.clipsToBounds = true
        }
        
        if viewPresenter.isDissmisable {
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func tapHandler() {

        viewPresenter.handleTap()
    }
    
}

@available(iOS 13.0, *)
extension PagoGiphyView: PagoGiphyPresenterView {
    
    func isHidden(hidden: Bool) {
        
        self.isHidden = hidden
    }
    
    func setup(media: Any) {
    
        if let media = media as? GPHMedia {
            animationView.media = media
            viewPresenter.aspectRatio = media.aspectRatio
        }
    }
    
    func setup(close: PagoLoadedImageViewPresenter) {
        
        self.clipsToBounds = false
        let closeView = PagoLoadedImageView(presenter: close)
        closeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeView)
        closeView.centerXAnchor.constraint(equalTo: animationView.trailingAnchor).isActive = true
        closeView.centerYAnchor.constraint(equalTo: animationView.topAnchor).isActive = true
    }
}
