//
//  
//  PagoControllerPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

class PagoPageControllerPresenter: BasePresenter {

    var model: PagoPageControllerModel {
        get { return (self.baseModel as! PagoPageControllerModel) }
        set { self.baseModel = newValue }
    }
    
    private var view: PresenterView? { return basePresenterView }

    var numberOfPages: Int {
        return model.numberOfPages
    }
    
    var indicatorColorType: UIColor.Pago {
        return model.style.indicatorColor
    }
    
    var dividerColorType: UIColor.Pago {
        return model.style.dividerColor
    }
    
    var currentIndicatorColorType: UIColor.Pago {
        return model.style.currentIndicatorColor
    }
    
    var currentIndex: Int {
        return model.currentIndex
    }
    
    func update(selected: Int) {
        model.currentIndex = selected
        view?.reloadView()
    }
}
