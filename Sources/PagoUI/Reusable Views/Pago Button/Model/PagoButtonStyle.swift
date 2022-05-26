//
//  PagoButtonStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public struct PagoButtonStyle {
    
    public var font: UIFont.Pago = .semiBold17
    public var textColor: UIColor.Pago = .white
    public var backgroundColor: UIColor.Pago
    public var cornerRadius: Int = 0
    public var isUnderlined: Bool = false
    public var placeholderStyle: HighlightedStyle?
    public var shadowStyle: ShadowStyle?
    public var borderStyle: BorderStyle?
    public var numberOfLines: Int = 1
    
    public init(font: UIFont.Pago = .semiBold17, textColor: UIColor.Pago = .white, backgroundColor: UIColor.Pago, cornerRadius: Int = 0, isUnderlined: Bool = false, placeholderStyle: HighlightedStyle? = nil, shadowStyle: ShadowStyle? = nil, borderStyle: BorderStyle? = nil, numberOfLines: Int = 1) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isUnderlined = isUnderlined
        self.placeholderStyle = placeholderStyle
        self.shadowStyle = shadowStyle
        self.borderStyle = borderStyle
        self.numberOfLines = numberOfLines
    }
}

public struct HighlightedStyle {
    public var colorType: UIColor.Pago
    public var fontType: UIFont.Pago
    public var isUnderlined: Bool = false
    
    public init(colorType: UIColor.Pago, fontType: UIFont.Pago, isUnderlined: Bool = false) {
        
        self.colorType = colorType
        self.fontType = fontType
        self.isUnderlined = isUnderlined
    }
}


public struct BorderStyle {
    public var colorType: UIColor.Pago = .dividers
    public var width: CGFloat = 2
    
    public init(colorType: UIColor.Pago = .dividers, width: CGFloat = 2) {
        self.colorType = colorType
        self.width = width
    }
}

public struct ShadowStyle {
    public var opacity: Float = 0.2
    public var radius: CGFloat = 3
    public var offset: CGSize = CGSize(width: 0.0, height: 3.0)
    public var colorType: UIColor.Pago = .blackBodyText
    
    public init(opacity: Float = 0.2, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: 3.0), colorType: UIColor.Pago = .blackBodyText) {
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
        self.colorType = colorType
    }
}

extension PagoButtonStyle {
    
    enum Pago {
        case mainActive, mainInactive, secondaryActive, secondaryInactive, underlinedActive, underlinedInactive
    }
    
    static func style(for type: Pago, isSelfSized: Bool = false) -> PagoButtonStyle {
        
        switch type {
        case .mainInactive:
            return PagoButtonStyle(font: .semiBold17, textColor: .white, backgroundColor: .lightGrayInactive, cornerRadius: isSelfSized ? 8 : 12)
        case .mainActive, .secondaryInactive:
            return PagoButtonStyle(font: .semiBold17, textColor: .white, backgroundColor: .greenPositive, cornerRadius: isSelfSized ? 8 : 12, shadowStyle: ShadowStyle())
        case .secondaryActive:
            let defaultStyle = PagoButtonStyle(font: .semiBold17, textColor: .greenPositive, backgroundColor: .lightGreenBackground, cornerRadius: isSelfSized ? 8 : 12)
            return defaultStyle
        case .underlinedActive:
            return PagoButtonStyle(font: .semiBold17, textColor: .blueHighlight, backgroundColor: .clear, isUnderlined: true)
        case .underlinedInactive:
            return PagoButtonStyle(font: .semiBold17, textColor: .grayTertiaryText, backgroundColor: .clear, isUnderlined: true)
        }
    }
}
