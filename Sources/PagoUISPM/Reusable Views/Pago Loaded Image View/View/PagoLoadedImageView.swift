//
//  
//  PagoLoadedImageView.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

open class PagoLoadedImageView: BaseView {
    
    private(set) var imageView: UIImageView!
    private var activityIndicatorView: UIActivityIndicatorView!

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    private var viewPresenter: PagoLoadedImageViewPresenter { return (presenter as! PagoLoadedImageViewPresenter) }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(size: CGSize(width: 8, height: 8))
    }
    
    public init(presenter: PagoLoadedImageViewPresenter) {
        
        super.init(frame: .zero)
        setupUI(size: presenter.style.size)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoLoadedImageViewPresenter) {
        self.presenter = presenter
        presenter.setView(mView: self)
        setupConstraints()
        presenter.loadData()
        imageView.isAccessibilityElement = false
        isAccessibilityElement = presenter.accessibility.isAccessibilityElement
        accessibilityTraits = presenter.accessibility.accessibilityTraits
        accessibilityLabel = presenter.accessibility.accessibilityLabel
    }
    
    public override func reloadView() {
        
        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        
        self.imageView.contentMode = self.viewPresenter.style.contentMode
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width 
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        self.topConstraint?.constant = self.viewPresenter.style.inset.top
        self.bottomConstraint?.constant = self.viewPresenter.style.inset.bottom
        self.trailingConstraint?.constant = self.viewPresenter.style.inset.right
        self.leadingConstraint?.constant = self.viewPresenter.style.inset.left
        if let borderStyle = self.viewPresenter.style.borderStyle {
            self.borderWidth = borderStyle.width
            self.borderColor = borderStyle.colorType.cgColor
        }
        self.layoutIfNeeded()
    }
    
    private func setupUI(size: CGSize?) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        let leading = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let top = imageView.topAnchor.constraint(equalTo: self.topAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        bottom.isActive = true
        self.leadingConstraint = leading
        self.trailingConstraint = trailing
        self.bottomConstraint = bottom
        self.topConstraint = top
        if let size = size {
            let width = imageView.widthAnchor.constraint(equalToConstant: size.width)
            width.isActive = true
            widthConstraint = width
            let height = imageView.heightAnchor.constraint(equalToConstant: size.height)
            height.isActive = true
            heightConstraint = height
        }
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
}

extension PagoLoadedImageView: PagoLoadedImageViewPresenterView {
    
    public func setup(labelPlaceholder: PagoLabelPresenter) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        
        let label = PagoLabel(presenter: labelPlaceholder)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = nil
        
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        layoutIfNeeded()
        label.alpha = viewPresenter.style.alpha
    }
    
    public func setup(image: UIImage.Pago) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        imageView.alpha = viewPresenter.style.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        if let tintColor = self.viewPresenter.style.tintColorType {
            self.imageView.image = image.image(tinted: tintColor)
        } else {
            self.imageView.image = image.image
        }
        layoutIfNeeded()
    }
    
    public func setup(data: Data) {
        
        activityIndicatorView.stopAnimating()
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        imageView.alpha = viewPresenter.style.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        if let tintColor = self.viewPresenter.style.tintColorType?.color {
            self.imageView.image = UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = tintColor
        } else {
            self.imageView.image = UIImage(data: data)
        }
        layoutIfNeeded()
    }
    
    public func resizeImage(width: CGFloat, height: CGFloat) {

        guard width > 0, height > 0 else { return }
        let aspectRatio = width / height
        if let size = self.viewPresenter.style.size, size.width ==  0 || size.height == 0 {
            if size.width > 0, size.height == 0 {
                let height = aspectRatio * -1 * size.width
                self.heightConstraint?.constant = height
                self.heightConstraint?.isActive = true
            }

            if size.height > 0, size.width == 0 {
                let width = aspectRatio * size.height
                self.widthConstraint?.constant = width
                self.widthConstraint?.isActive = true
            }
        }

    }
    
    public func setup(backend: BackendImage) {
     
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.viewPresenter.style.backgroundCornerRadius)
        imageView.alpha = viewPresenter.style.alpha
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.viewPresenter.style.cornerRadius)
        self.backgroundColor = self.viewPresenter.style.backgroundColorType.color
        let url = URL(string: backend.url)
        self.activityIndicatorView.startAnimating()
        let placeholder = backend.placeholderImageName.isEmpty ? UIImage() : UIImage(named: backend.placeholderImageName)
        
        self.resizeImage(width: placeholder?.size.width ?? 0, height: placeholder?.size.height ?? 0)
#warning("Fix this")
        //TODO: Should fix this
//        imageView.sd_setImage(with: url, placeholderImage: placeholder) { [weak self] (image, _, _, _) in
//            DispatchQueue.main.async { [weak self] in
//
//                guard let self = self else { return }
//                if let image = image {
//                    self.imageView.backgroundColor = self.viewPresenter.style.backgroundColorType.color
//                    self.resizeImage(width: image.width, height: image.height)
//                    if let tint = self.viewPresenter.style.tintColorType {
//                        image.bw { bw in
//                            bw?.tint(color: tint.color) { bw in
//                                self.imageView.image = bw
//                                self.activityIndicatorView.stopAnimating()
//                            }
//                        }
//                    } else {
//                        self.imageView.image = image
//                        self.activityIndicatorView.stopAnimating()
//                    }
//                } else {
//                    self.activityIndicatorView.stopAnimating()
//                }
//            }
//        }
        imageView.contentMode = viewPresenter.style.contentMode
        if let size = self.viewPresenter.style.size {
            self.widthConstraint?.constant = size.width
            self.heightConstraint?.constant = size.height
            self.widthConstraint?.isActive = size.width > 0
            self.heightConstraint?.isActive = size.height > 0
        } else {
            self.widthConstraint?.isActive = false
            self.heightConstraint?.isActive = false
        }
        layoutIfNeeded()
    }
}
