//
//  
//  PagoTextFieldPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation

protocol PagoTextFieldPresenterView: PresenterView {
    
    func update(accessibility: PagoAccessibility)
    func showError(message: String?, hasDetail: Bool)
    func showValid(message: String?, hasDetail: Bool)
    func focus()
    func dismiss()
}

protocol PagoTextFieldPresenterDelegate: AnyObject {
    
    func willUpdate(presenter: PagoTextFieldPresenter)
    func didTapDelete(presenter: PagoTextFieldPresenter)
    func didBeginEditing(presenter: PagoTextFieldPresenter)
    func didEndEditing(presenter: PagoTextFieldPresenter)
    func didUpdate(presenter: PagoTextFieldPresenter)
    func didDismiss(index: Int)
    func didTapButton(presenter: PagoTextFieldPresenter)
    func didReturn(presenter: PagoTextFieldPresenter)
}

extension PagoTextFieldPresenterDelegate {

    func willUpdate(presenter: PagoTextFieldPresenter) {}
    func didUpdate(presenter: PagoTextFieldPresenter) {}
    func didDismiss(index: Int) {}
    func didTapDelete(presenter: PagoTextFieldPresenter) {}
    func didBeginEditing(presenter: PagoTextFieldPresenter) {}
    func didEndEditing(presenter: PagoTextFieldPresenter) {}
    func didTapButton(presenter: PagoTextFieldPresenter) {}
    func didReturn(presenter: PagoTextFieldPresenter) {}
}

open class PagoTextFieldPresenter: BasePresenter {

    weak var delegate: PagoTextFieldPresenterDelegate?
    public var model: PagoTextFieldModel {
        get { return (self.baseModel as! PagoTextFieldModel) }
        set { self.baseModel = newValue }
    }
    public var error: String? { return model.error }
    public var text: String? {
        get { return model.text }
        set { model.text = newValue }
    }
    public var placeholder: String {
        get { return model.placeholder }
        set { model.placeholder = newValue}
    }
    public var hasRightButton: Bool {
        return buttonPresenter != nil 
    }
    public var detail: String? { return model.detail }
    public var isValid: Bool?
    public var style: PagoTextFieldStyle {
        get { return model.style }
        set { model.style = newValue }
    }
    internal var buttonPresenter: PagoButtonPresenter?
    internal var accessibility: PagoAccessibility { return model.accessibility }
    internal var shouldReplaceString: ((String, NSRange, String) -> (Bool))?
    
    private let linePresenter: PagoLinePresenter
    private var validation: ((String?) -> (Bool))?
    private let index: Int?
    private var isFirstTimeEditing = true
    private var lastText: String?
    
    private var view: PagoTextFieldPresenterView? { return basePresenterView as? PagoTextFieldPresenterView  }
    
    public init(model: PagoTextFieldModel, index: Int? = nil, isValid: Bool? = nil, validation: ((String?) -> (Bool))? = nil, shouldReplaceString: ((String, NSRange, String) -> (Bool))? = nil) {

        self.linePresenter = PagoLinePresenter(model: PagoLineModel(style: PagoLineStyle(color: model.style.textFieldDefaultLineColor)))
        self.validation = validation
        self.index = index
        self.isValid = isValid
        if let shouldReplaceString = shouldReplaceString {
            self.shouldReplaceString = shouldReplaceString
        }
        if let buttonModel = model.button {
            self.buttonPresenter = PagoButtonPresenter(model: buttonModel)
            buttonPresenter?.delegate = delegate as? PagoButtonPresenterDelegate
        }
        super.init()
        if let buttonModel = model.button {
            buttonPresenter = PagoButtonPresenter(model: buttonModel)
            buttonPresenter?.delegate = self
        }
        update(model: model)
        
        view?.update(accessibility: model.accessibility)
        self.model.didUpdateAccessibility = { [weak self] accessibility in
            self?.view?.update(accessibility: accessibility)
        }
    }
    
    public func updateText(text: String) {
        
        model.text = text
        view?.reloadView()
    }
    
    public func update(placeholder: String, reload: Bool = true) {
        
        model.placeholder = placeholder
        if reload {
            view?.reloadView()
        }
    }

    public func removeButton() {
        
        buttonPresenter = nil
        model.button = nil
        view?.reloadView()
    }
    
    public func addButton(button: PagoButtonModel, reload: Bool = true) {
        
        model.button = button
        buttonPresenter = PagoButtonPresenter(model: button)
        buttonPresenter?.delegate = self
        if reload {
            view?.reloadView()
        }
    }
    
    public func update(button: PagoButtonModel) {
        
        buttonPresenter?.update(model: button)
    }
    
    public func update(style: PagoTextFieldStyle, reload: Bool = true) {
        
        model.style = style
        if reload {
            view?.reloadView()
        }
    }
    
    public func reloadLine() {
        
        linePresenter.view?.reloadView()
    }
    
    public func validateFieldAndForceErrorsIfAny() {
        
        isFirstTimeEditing = false
        validateField()
    }
    
    public func validateField() {
        
        if isFirstTimeEditing {
            isFirstTimeEditing = false
        }
        validate(text: text)
    }
    
    public func didUpdate() {
        
        delegate?.didUpdate(presenter: self)
    }
    
    public func validate(text: String?) {
        
        self.text = text
        isValid = validation?(text) ?? true
        if isValid == true {
            hideError()
        } else if !isFirstTimeEditing, isValid == false {
            showError()
        }
        if lastText != text {
            lastText = text
            delegate?.willUpdate(presenter: self)
        }
    }
    
    public func showCustomError(message: String) {
        
        view?.showError(message: message, hasDetail: true)
        linePresenter.update(color: model.style.textFieldInvalidLineColor)
    }
    
    public func showError() {
        
        view?.showError(message: error, hasDetail: error != nil)
        linePresenter.update(color: model.style.textFieldInvalidLineColor)
    }
    
    public func hideError() {
        
        view?.showValid(message: detail, hasDetail: detail != nil)
        linePresenter.update(color: model.style.textFieldDefaultLineColor)
    }
    
    public func shouldReturn() {
        
        isFirstTimeEditing = false
        validateField()
        shouldDismiss()
        delegate?.didReturn(presenter: self)
    }
    
    public func shouldDismiss() {
        
        if let indexT = index {
            delegate?.didDismiss(index: indexT)
        } else {
            dismiss()
        }
    }
    
    public func clearData() {
        
        model.text = nil
        view?.reloadView()
    }
    
    public func focus() {
        
        guard style.isUserInteractionEnabled else {
            if let indexT = index {
                delegate?.didDismiss(index: indexT)
            }
            return
        }
        view?.focus()
    }

    public func dismiss() {
        
        view?.dismiss()
    }

    public func didTapDelete() {
        
        delegate?.didTapDelete(presenter: self)
    }
    
    public func didEndEditing() {
        
        delegate?.didEndEditing(presenter: self)
        validateField()
    }
    
    public func didBeginEditing() {
        
        delegate?.didBeginEditing(presenter: self)
    }

    public func enable() {
        model.style.isUserInteractionEnabled = true
    }
    
    public func disable() {
        model.style.isUserInteractionEnabled = false
    }
    
    public func forceInvalidStyle() {
        showError()
    }
    
    public func forceDefaultStyle() {
        hideError()
    }
}

extension PagoTextFieldPresenter: PagoButtonPresenterDelegate {
    
    public func didTap(button: PagoButtonPresenter) {
        
        delegate?.didTapButton(presenter: self)
    }
}
