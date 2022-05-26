//
//  
//  PagoCheckboxModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoCheckboxModel: Model {
    
    public var title: String?
    public var highlightedText: String?
    public var isSelected = false
    public let selectedStyle: PagoCheckboxStyle
    public var deselectedStyle: PagoCheckboxStyle
    public var errorStyle: PagoCheckboxStyle?
    public var hasInfo = false
    public let transitionTime: Double = 0.15
    public var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.button)
    
    public init(title: String? = nil, highlightedText: String? = nil, isSelected: Bool = false, selectedStyle: PagoCheckboxStyle, deselectedStyle: PagoCheckboxStyle, errorStyle: PagoCheckboxStyle? = nil, hasInfo: Bool = false, transitionTime: Double = 0.15, accessibility: PagoAccessibility) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.isSelected = isSelected
        self.selectedStyle = selectedStyle
        self.deselectedStyle = deselectedStyle
        self.errorStyle = errorStyle
        self.hasInfo = hasInfo
        self.accessibility = accessibility
    }
}
