//
//  
//  PagoMenuButtonPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 07/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public protocol PagoMenuPresenterView: PresenterView {
    func setup(buttons: [PagoButtonPresenter])
    func selectButton(index: Int, animated: Bool)
}

public protocol PagoMenuPresenterDelegate: AnyObject {
    func menuDidSelect(index: Int)
}

open class PagoMenuPresenter: BasePresenter {
    
    public weak var delegate: PagoMenuPresenterDelegate?
    
    public var model: PagoMenuModel {
       return (self.baseModel as! PagoMenuModel)
    }
    public var inactiveColorType: UIColor.Pago {
        return model.style.inactiveLineColorType
    }
    public var activeColorType: UIColor.Pago {
        return model.style.activeLineColorType
    }
    public var buttonsCount: Int {
        return model.buttons.count
    }
    public var buttonWidthPercentage: Double {
        return 1.0/Double(model.buttons.count)
    }
    public var selectedIndex = 0

    private let repository = PagoMenuRepository()
    private var view: PagoMenuPresenterView? { return basePresenterView as? PagoMenuPresenterView }
    private var buttons = [PagoButtonPresenter]()
    
    public func loadData() {
        
        let buttonModels = repository.buttonModels(from: model.buttons)
        buttons = buttonModels.map({PagoButtonPresenter(model: $0)})
        buttons.forEach({$0.delegate = self})
        view?.setup(buttons: buttons)
    }

    public func select(index: Int) {
        
        guard isInBounds(source: buttons, index: index) else { return }
        let button = buttons[index]
        didTap(button: button, animated: false)
    }

    public func button(at index: Int) -> PagoButtonPresenter? {
        
        guard isInBounds(source: buttons, index: index) else { return nil }
        return buttons[index]
    }
    
    private func didTap(button: PagoButtonPresenter, animated: Bool = true) {
        
        guard selectedIndex != button.index else { return }
        selectedIndex = button.index
        view?.selectButton(index: button.index, animated: true)
        delegate?.menuDidSelect(index: selectedIndex)
    }
}

extension PagoMenuPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        didTap(button: button, animated: true)
    }
}
