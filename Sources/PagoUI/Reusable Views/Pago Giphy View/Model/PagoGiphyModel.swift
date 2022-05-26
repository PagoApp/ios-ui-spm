//
//  
//  PagoGiphyModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 16.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import UIKit

public struct PagoGiphyModel: Model {
    public let mediaId: String
    public let loop: Bool
    public let isDissmisable: Bool
    public let style: PagoGiphyStyle
    public let accessibility: PagoAccessibility
    
    public init(mediaId: String, loop: Bool, isDissmisable: Bool, style: PagoGiphyStyle, accessibility: PagoAccessibility) {
        
        self.mediaId = mediaId
        self.isDissmisable = isDissmisable
        self.loop = loop
        self.style = style
        self.accessibility = PagoAccessibility(isAccessibilityElement: false, accessibilityTraits: UIAccessibilityTraitNone)
    }
}

public struct PagoGiphyStyle: BaseStyle {
    public var size: CGSize?
    public var backgroundColorType: UIColor.Pago = .clear
    public var cornerRadius: Int?
    public var inset: UIEdgeInsets = UIEdgeInsets.zero
    
    public init(size: CGSize?, backgroundColorType: UIColor.Pago = .clear, cornerRadius: Int?, inset: UIEdgeInsets = UIEdgeInsets.zero)  {
        
        self.size = size
        self.backgroundColorType = backgroundColorType
        self.cornerRadius = cornerRadius
        self.inset = inset
    }
}
