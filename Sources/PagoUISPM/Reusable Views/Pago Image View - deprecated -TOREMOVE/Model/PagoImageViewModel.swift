//
//  
//  PagoImageModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoImageViewModel: Model {
    public var imageType: UIImage.Pago
    public var style: PagoImageViewStyle
    public var accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraitImage)
    
    public init(imageType: UIImage.Pago, style: PagoImageViewStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraitImage)) {
        
        self.imageType = imageType
        self.style = style
        self.accessibility = accessibility
    }
}

public struct PagoImageViewStyle: BaseViewStyle {
    public var size: CGSize? = nil
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    public var tintColorType: UIColor.Pago?
    public var backgroundColorType: UIColor.Pago = .clear
    public var contentMode: UIViewContentMode = .scaleAspectFit
    public var cornerRadius: Int = 0
    public var backgroundCornerRadius: Int = 0
    public var borderStyle: BorderStyle?
    public var alpha: CGFloat = 1.0
    
    public init(size: CGSize? = nil, inset: UIEdgeInsets = UIEdgeInsets.zero, tintColorType: UIColor.Pago? = nil, backgroundColorType: UIColor.Pago = .clear, contentMode: UIViewContentMode = .scaleAspectFit, cornerRadius: Int = 0, backgroundCornerRadius: Int = 0, borderStyle: BorderStyle? = nil, alpha: CGFloat = 1.0) {
        
        self.size = size
        self.inset = inset
        self.tintColorType = tintColorType
        self.backgroundColorType = backgroundColorType
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
        self.backgroundCornerRadius = backgroundCornerRadius
        self.borderStyle = borderStyle
        self.alpha = alpha
    }
}
