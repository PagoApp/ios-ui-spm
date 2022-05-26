//
//  
//  PagoTextFieldModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoTextFieldModel: Model {
    public var text: String? {
        didSet {
            accessibility.accessibilityLabel = accessibilityLabel
            didUpdateAccessibility?(accessibility)
        }
    }
    public var placeholder: String
    public var detail: String?
    public var button: PagoButtonModel?
    @available(*, deprecated, message: "Use validationRules instead")
    public var error: String?
    public var validationRules: [ValidationModel]?
    public var style: PagoTextFieldStyle = PagoTextFieldStyle()
    public var accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button)
    
    private var accessibilityLabel: String? {
        let titleText = placeholder
        let userText = text ?? ""
        let detailText = detail ?? ""
        return "\(titleText) \(userText) \(detailText)"
    }
    
    public var didUpdateAccessibility: ((PagoAccessibility)->())?
    
    public init(text: String? = nil, placeholder: String, detail: String? = nil, button: PagoButtonModel? = nil, error: String? = nil, validationRules: [ValidationModel]? = nil, style: PagoTextFieldStyle = PagoTextFieldStyle(), accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraits.button)) {
        
        self.text = text
        self.placeholder = placeholder
        self.detail = detail
        self.button = button
        self.error = error
        self.validationRules = validationRules
        self.style = style
        self.accessibility = accessibility
    }
    
    /**
     Used to maintain backwards compatibility with the previous validation implementation method
     - Parameter validation: function used to validate textField input
     */
    mutating func updateValidationRules(validation: ((String?) -> (Bool))? = nil) {

        guard let validation = validation else {
            validationRules = nil
            return
        }

        if validationRules == nil {
            validationRules = [ValidationModel]()
        }

        if let error = error {
            validationRules?.insert(ValidationModel(validation: validation, error: error), at: 0)
        }
    }
}
