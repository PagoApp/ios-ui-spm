//
//  
//  PagoImagePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public protocol PagoSimpleViewPresenterView: PresenterView {
    func setupView(style: PagoSimpleViewStyle)
}

open class PagoSimpleViewPresenter: BasePresenter {

    var model: PagoSimpleViewModel { return (self.baseModel as! PagoSimpleViewModel) }
    var accessibility: PagoAccessibility { return model.accessibility }
    private var view: PagoSimpleViewPresenterView? { return basePresenterView as? PagoSimpleViewPresenterView}
    
    
    func loadData() {
        
        view?.setupView(style: model.style)
        
    }
}
