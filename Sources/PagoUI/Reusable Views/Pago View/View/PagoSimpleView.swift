//
//  
//  PagoView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

open class PagoSimpleView: BaseView {
  
    private var baseView: UIView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    private var viewPresenter: PagoSimpleViewPresenter { return (presenter as! PagoSimpleViewPresenter) }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupUI()
    }
    
    public init(presenter: PagoSimpleViewPresenter) {
        
        super.init(frame: .zero)
        setupUI()
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoSimpleViewPresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
        baseView.isAccessibilityElement = false
        isAccessibilityElement = presenter.accessibility.isAccessibilityElement
        accessibilityTraits = presenter.accessibility.accessibilityTraits
        accessibilityLabel = presenter.accessibility.accessibilityLabel
    }
    
    private func setupUI() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(baseView)
        let leading = baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let top = baseView.topAnchor.constraint(equalTo: self.topAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: baseView.trailingAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: baseView.bottomAnchor)
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        bottom.isActive = true
        self.leadingConstraint = leading
        self.trailingConstraint = trailing
        self.bottomConstraint = bottom
        self.topConstraint = top
    }
}

extension PagoSimpleView: PagoSimpleViewPresenterView {
    
    public func setupView(style: PagoSimpleViewStyle) {
        
        if let tintColor = style.tintColorType?.color {
            baseView.tintColor = tintColor
        }
        
        self.layer.cornerRadius = CGFloat(style.cornerRadius)
        
        if let border = style.borderStyle {
            borderColor = border.colorType.cgColor
            borderWidth = border.width
        }
        
        clipsToBounds = true
        backgroundColor = style.backgroundColorType.color
        
        if let viewWidth = style.width {
            let width = self.widthAnchor.constraint(equalToConstant: viewWidth)
            width.isActive = true
            widthConstraint = width
        }
        if let viewHeight = style.height {
            let height = self.heightAnchor.constraint(equalToConstant: viewHeight)
            height.isActive = true
            heightConstraint = height
        }
        layoutIfNeeded()
    }
}
