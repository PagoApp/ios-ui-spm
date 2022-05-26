//
//  
//  PagoCheckboxPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

protocol PagoCheckboxPresenterView: PresenterView {
    
    func update(style: PagoCheckboxStyle)
    func update(accessibility: PagoAccessibility)
    func update(title: String)
    func hideView(isHidden: Bool)
}

protocol PagoCheckboxPresenterDelegate: AnyObject {
    
    func didUpdate(presenter: PagoCheckboxPresenter)
    func didTapInfo(presenter: PagoCheckboxPresenter)
}

extension PagoCheckboxPresenterDelegate {
    func didTapInfo(presenter: PagoCheckboxPresenter) {}
}

class PagoCheckboxPresenter: BasePresenter {
    
    weak var delegate: PagoCheckboxPresenterDelegate?
    var title: String {
        return model.title ?? ""
    }
    var hasInfo: Bool {
        return model.hasInfo == true
    }
    var isSelected: Bool {
        get { return model.isSelected }
        set { model.isSelected = newValue }
    }
    var isEnabled: Bool = true
    var model: PagoCheckboxModel {
        get { return (self.baseModel as! PagoCheckboxModel) }
        set { baseModel = newValue }
    }
    var forceError: Bool = false
    var highlightedText: String? {
        return model.highlightedText
    }
    var style: PagoCheckboxStyle {
        if forceError, let errorStyleT = errorStyle {
            return errorStyleT
        }
        return isSelected ? selectedStyle : deselectedStyle
    }
    var accessibility: PagoAccessibility {
        get { return model.accessibility }
        set { model.accessibility = newValue }
    }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
    
    private var view: PagoCheckboxPresenterView? { return basePresenterView as? PagoCheckboxPresenterView }
    private var selectedStyle: PagoCheckboxStyle { return model.selectedStyle }
    private var deselectedStyle: PagoCheckboxStyle { return model.deselectedStyle }
    private var errorStyle: PagoCheckboxStyle? { return model.errorStyle }
    var highlightedStyle: HighlightedStyle? { return style.highlightedStyle }
    var transitionTime: Double { return model.transitionTime }
    
    func toggleSelection() {
        
        isSelected = !isSelected
        if forceError, isSelected {
            forceError = false
        }
        view?.update(style: style)
        update(accessibility: accessibility)
        delegate?.didUpdate(presenter: self)
    }
    
    func updateSelection(selected: Bool) {
        guard selected != isSelected else {
            return
        }
        isSelected = selected
        view?.update(style: style)
        update(accessibility: accessibility)
    }
    
    func update(title: String) {
        
        model.title = title
        view?.update(title: title)
        accessibility.accessibilityLabel = title
        view?.update(accessibility: accessibility)
    }
    
    func showInfo() {
        
        guard isEnabled else { return }
        delegate?.didTapInfo(presenter: self)
    }
    
    func loadState() {
        
        view?.update(style: style)
    }
    
    func validateCheckboxAndForceErrorsIfAny() {
        
        guard forceError != !isSelected else { return }
        forceError = !isSelected
        view?.update(style: style)
    }
    
    func update(accessibility: PagoAccessibility) {
        
        model.accessibility = accessibility
        view?.update(accessibility: accessibility)
    }
}
