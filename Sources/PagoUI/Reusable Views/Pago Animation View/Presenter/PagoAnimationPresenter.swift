//
//  
//  PagoAnimationPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

public protocol PagoAnimationPresenterView: PresenterView {
    func play()
    func stop()
}

open class PagoAnimationPresenter: BasePresenter {

    public var model: PagoAnimationModel { return (self.baseModel as! PagoAnimationModel) }
    public var style: PagoAnimationStyle { return model.style }
    public var loop: Bool { return model.loop }
    public var animation: String { return model.animationType.animation }
    public var accessibility: PagoAccessibility { return model.accessibility }
    private(set) var isAnimating: Bool = false
    private var view: PagoAnimationPresenterView? { return basePresenterView as? PagoAnimationPresenterView }
    
    public override func update(model: Model) {
        
        super.update(model: model)
        view?.reloadView()
    }
    
    public func play() {
        
        isAnimating = true
        view?.play()
    }
    
    public func stop() {
        
        isAnimating = false
        view?.stop()
    }
}
