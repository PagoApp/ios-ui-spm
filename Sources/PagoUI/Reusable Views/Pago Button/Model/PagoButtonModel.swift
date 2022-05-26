//
//  
//  PagoButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoButtonModel: Model {

    public var title: String?
    public var highlightedText: String?
    public var imageView: PagoImageViewModel?
    public var isEnabled: Bool = true
    public var isSelfSized: Bool = false
    public var index: Int = 0
    public var style: PagoButtonStyle
    public var highlightedStyle: PagoButtonStyle?
    public var inactiveStyle: PagoButtonStyle?
    public var badge: PagoBadgePredicate?
    public var width: CGFloat?
    public var height: CGFloat?
    //NOTE(Qsa): If we don't provide a custom text for accessibility, we will just add the button's title
    public var accessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraitButton)
    
    public init(title: String? = nil, highlightedText: String? = nil, imageView: PagoImageViewModel? = nil, isEnabled: Bool = true, isSelfSized: Bool = false, index: Int = 0, style: PagoButtonStyle,  highlightedStyle: PagoButtonStyle? = nil, inactiveStyle: PagoButtonStyle? = nil, badge: PagoBadgePredicate? = nil, width: CGFloat? = nil, height: CGFloat? = nil, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: true, accessibilityTraits: UIAccessibilityTraitButton)) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.imageView = imageView
        self.isEnabled = isEnabled
        self.isSelfSized = isSelfSized
        self.index = index
        self.style = style
        self.highlightedStyle = highlightedStyle
        self.inactiveStyle = inactiveStyle
        self.badge = badge
        self.width = width
        self.height = height
        self.accessibility = accessibility
    }
}


public extension PagoButtonModel {
    
    enum Pago {
        case main, secondary, underlined
    }
    
    init(title: String? = nil, highlightedText: String? = nil, imageView: PagoImageViewModel? = nil, isEnabled: Bool = true, isSelfSized: Bool = false, highlightedStyle: PagoButtonStyle? = nil, type: Pago, badge: PagoBadgePredicate? = nil, height: CGFloat? = nil) {
        
        self.title = title
        self.highlightedText = highlightedText
        self.imageView = imageView
        self.isEnabled = isEnabled
        self.isSelfSized = isSelfSized
        self.highlightedStyle = highlightedStyle
        self.badge = badge
        self.height = height
        
        switch type {
        case .main:
            style = PagoButtonStyle.style(for: .mainActive)
            inactiveStyle = PagoButtonStyle.style(for: .mainInactive)
        case .secondary:
            style = PagoButtonStyle.style(for: .secondaryActive)
            inactiveStyle = PagoButtonStyle.style(for: .secondaryInactive)
        case .underlined:
            style = PagoButtonStyle.style(for: .underlinedActive)
            inactiveStyle = PagoButtonStyle.style(for: .underlinedInactive)
        }
    }
}
