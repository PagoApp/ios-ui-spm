//
//  
//  PagoBadgeButtonPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoBadgePresenterView: PresenterView {
    func setup(badge: PagoLabelPresenter, background: UIColor.Pago)
    func show()
    func hide()
}

open class PagoBadgePresenter: BasePresenter {

    public var position: PagoBadgePosition {
        return predicate.position
    }
 
    public var model: PagoBadgeModel {
       return (self.baseModel as! PagoBadgeModel)
    }
    private var badgePresenter: PagoLabelPresenter!
    
    private var view: PagoBadgePresenterView? { return basePresenterView as? PagoBadgePresenterView }
    private let predicate:  PagoBadgePredicate
    private let repository = PagoBadgeRepository()
    
    public init(predicate: PagoBadgePredicate) {
        
        self.predicate = predicate
        super.init()
        guard let model = self.repository.getData(predicate: predicate) else { return }
        update(model: model)
    }
    
    internal func loadData() {
        
        badgePresenter = PagoLabelPresenter(model: model.badge)
        view?.setup(badge: badgePresenter, background: predicate.backgroundColor)
        if badgePresenter.text.isEmpty {
            view?.hide()
        }
    }
    
    public func update(predicate: PagoBadgePredicate) {
        
        guard let model = self.repository.getData(predicate: predicate) as? PagoBadgeModel else { return }
        update(model: model)
        badgePresenter.update(model: model.badge)
        view?.reloadView()
        if badgePresenter.text.isEmpty {
            view?.hide()
        } else {
            view?.show()
        }
    }
    
    public func update(text: String) {
        
        badgePresenter.update(text: text)
    }
    
    public func hide() {
        
        view?.hide()
    }
    
    public func show() {
        
        view?.show()
    }
}
