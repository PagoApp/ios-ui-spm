//
//  
//  PagoAnimationView.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Lottie
import UIKit
import Foundation

open class PagoAnimationView: BaseView {
        
    private var animationView: AnimationView!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var viewPresenter: PagoAnimationPresenter { return (presenter as! PagoAnimationPresenter) }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public init(presenter: PagoAnimationPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoAnimationPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        loadData()
    }
    
    private func loadData() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        animationView = AnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        let width = self.widthAnchor.constraint(equalToConstant: self.viewPresenter.style.size.width)
        width.isActive = true
        widthConstraint = width
        let height = self.heightAnchor.constraint(equalToConstant: self.viewPresenter.style.size.height)
        height.isActive = true
        heightConstraint = height
        self.animationView.animation = Animation.named(self.viewPresenter.animation)
        self.animationView.loopMode = self.viewPresenter.loop ? .loop : .playOnce
        self.animationView.play()

        animationView.isAccessibilityElement = false
        isAccessibilityElement = viewPresenter.accessibility.isAccessibilityElement
        accessibilityTraits = viewPresenter.accessibility.accessibilityTraits
        accessibilityLabel = viewPresenter.accessibility.accessibilityLabel
    }
    
    public override func reloadView() {

        super.reloadView()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3) {
                self.widthConstraint?.constant = self.viewPresenter.style.size.width
                self.heightConstraint?.constant = self.viewPresenter.style.size.height
                self.layoutIfNeeded()
            }
            self.animationView.animation = Animation.named(self.viewPresenter.animation)
            self.animationView.loopMode = self.viewPresenter.loop ? .loop : .playOnce
            self.animationView.play()
        }
    }
}

extension PagoAnimationView: PagoAnimationPresenterView {
    
    public func play() {
     
        animationView.play()
    }
    
    public func stop() {
        
        animationView.stop()
    }
}
