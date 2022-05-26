//
//  
//  PagoSpacePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public protocol PagoSpacePresenterView: PresenterView {
    func setup(size: CGSize)
}

open class PagoSpacePresenter: BasePresenter {


    public var model: PagoSpaceModel {
       return (self.baseModel as! PagoSpaceModel)
    }
    
    private var view: PagoSpacePresenterView? { return basePresenterView as? PagoSpacePresenterView }
    
    internal func loadData() {
     
        view?.setup(size: model.size)
    }
}
