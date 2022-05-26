//
//  
//  PagoImageModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

public struct PagoSimpleViewModel: Model {
    let style: PagoSimpleViewStyle
    var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraitImage)
    
    public init(style: PagoSimpleViewStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraitImage)) {
        
        self.style = style
        self.accessibility = accessibility
    }
}

public struct PagoSimpleViewStyle: BaseViewStyle {
    
    public var width: CGFloat?
    public var height: CGFloat?
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    public var backgroundColorType: UIColor.Pago = .clear
    public var tintColorType: UIColor.Pago?
    public var cornerRadius: Int = 0
    public var borderStyle: BorderStyle?
    
    public init(width: CGFloat? = nil, height: CGFloat? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, backgroundColorType: UIColor.Pago = .clear, tintColorType: UIColor.Pago? = nil, cornerRadius: Int = 0, borderStyle: BorderStyle? = nil) {
        
        self.width = width
        self.height = height
        self.inset = inset
        self.backgroundColorType = backgroundColorType
        self.tintColorType = tintColorType
        self.cornerRadius = cornerRadius
        self.borderStyle = borderStyle
    }
}
