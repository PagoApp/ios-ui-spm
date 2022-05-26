//
//  
//  PagoAnimationModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoAnimationModel: Model {
    public let animationType: UIImage.PagoAnimation
    public let loop: Bool
    public let style: PagoAnimationStyle
    public let accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)
    
    public init(animationType: UIImage.PagoAnimation, loop: Bool, style: PagoAnimationStyle, accessibility: PagoAccessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraits.none)) {
        
        self.animationType = animationType
        self.loop = loop
        self.style = style
    }
}

public struct PagoAnimationStyle: BaseStyle {
    public let size: CGSize
    public let backgroundColorType: UIColor.Pago
    
    public init(size: CGSize, backgroundColorType: UIColor.Pago = .clear) {
        
        self.size = size
        self.backgroundColorType = backgroundColorType
    }
}
