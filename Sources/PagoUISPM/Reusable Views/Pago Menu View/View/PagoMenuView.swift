//
//  
//  PagoMenuButtonView.swift
//  Pago
//
//  Created by Gabi Chiosa on 07/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

open class PagoMenuView: BaseView {
    
    private var stackView: PagoStackView!
    private var lineView: UIView!
    private var selectedView: UIView!
    private var buttons = [PagoButton]()
    private var selectedCenterXConstraint: NSLayoutConstraint?
        
    private var presenterView: PagoMenuPresenter {
        return presenter as! PagoMenuPresenter
    }

    public init() {
        
        super.init(frame: .zero)
    }
    
    public convenience init(presenter: PagoMenuPresenter) {
        
        self.init()
        setup(presenter: presenter)
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    public func setup(presenter: PagoMenuPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        
        backgroundColor = .white
        stackView = PagoStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView.backgroundColor = presenterView.inactiveColorType.color
        
        selectedView = UIView()
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectedView)
        selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        selectedView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        selectedView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(presenter.buttonWidthPercentage)).isActive = true
        selectedView.backgroundColor = presenterView.activeColorType.color

        presenterView.loadData()
    }

    public func goToLogin() {
        
        presenterView.select(index: 1)
    }
    
    public func goToRegister() {
        
        presenterView.select(index: 0)
    }
    
}

extension PagoMenuView: PagoMenuPresenterView {
    
    public func selectButton(index: Int, animated: Bool) {
            
        guard index < buttons.count else { return }
        let button = buttons[index]
        
        UIView.animate(withDuration: animated ? 0.3 : 0) { [weak self] in
            guard let self = self else { return }
            self.selectedCenterXConstraint?.isActive = false
            let centerConstraint = self.selectedView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
            centerConstraint.isActive = true
            self.selectedCenterXConstraint = centerConstraint
            self.layoutIfNeeded()
        }
    }
    
    public func setup(buttons: [PagoButtonPresenter]) {
    
        let buttonsViews: [PagoButton] = buttons.map({PagoButton(presenter: $0)})
        buttonsViews.forEach { button in
            self.buttons.append(button)
            stackView.addArrangedSubview(button)
            button.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        }
        
    }
}
