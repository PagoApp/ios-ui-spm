//
//  PagoCheckboxStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public enum PagoCheckboxType {
    case circle, roundedSquare
}
public enum PagoCheckBoxSize: Int {
    case small = 20, large = 24
}

public struct PagoCheckboxStyle: BaseStyle {

    public let imageType: UIImage.Pago
    public let imageColorType: UIColor.Pago
    public let fontColorType: UIColor.Pago
    public let fontType: UIFont.Pago
    public let imageSize: PagoCheckBoxSize
    public var highlightedStyle: HighlightedStyle = HighlightedStyle(colorType: .blackBodyText, fontType: .regular15, isUnderlined: true)
    
    public init(imageType: UIImage.Pago, imageColorType: UIColor.Pago, fontColorType: UIColor.Pago, fontType: UIFont.Pago, imageSize: PagoCheckBoxSize, highlightedStyle: HighlightedStyle = HighlightedStyle(colorType: .blackBodyText, fontType: .regular15, isUnderlined: true)) {
        
        self.imageType = imageType
        self.imageColorType = imageColorType
        self.fontColorType = fontColorType
        self.fontType = fontType
        self.imageSize = imageSize
        self.highlightedStyle = highlightedStyle
    }
}

extension PagoCheckboxStyle {

    enum Pago {
        case none
        case roundedSmallSelected, roundedSmallDeselected, roundedSmallError
        case roundedLargeSelected, roundedLargeDeselected, roundedLargeError
        case squareSmallSelected, squareSmallDeselected, squareSmallError
        case squareLargeSelected, squareLargeDeselected, squareLargeError
    }
    
    static func style(for type: Pago) -> PagoCheckboxStyle {
        
        switch type {
        case .none:
            return PagoCheckboxStyle(imageType: .none, imageColorType: .clear, fontColorType: .clear, fontType: .regular15, imageSize: .large)
        case .roundedSmallError:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxDeselected, imageColorType: .redNegative, fontColorType: .redNegative, fontType: .regular15, imageSize: .small, highlightedStyle: HighlightedStyle(colorType: .redNegative, fontType: .regular15, isUnderlined: true))
        case .roundedLargeError:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxDeselected, imageColorType: .redNegative, fontColorType: .redNegative, fontType: .regular15, imageSize: .large, highlightedStyle: HighlightedStyle(colorType: .redNegative, fontType: .regular15, isUnderlined: true))
        case .squareSmallError:
            return PagoCheckboxStyle(imageType: .checkBoxDeselected, imageColorType: .redNegative, fontColorType: .redNegative, fontType: .regular15, imageSize: .small, highlightedStyle: HighlightedStyle(colorType: .redNegative, fontType: .regular15, isUnderlined: true))
        case .squareLargeError:
            return PagoCheckboxStyle(imageType: .checkBoxDeselected, imageColorType: .redNegative, fontColorType: .redNegative, fontType: .regular15, imageSize: .large, highlightedStyle: HighlightedStyle(colorType: .redNegative, fontType: .regular15, isUnderlined: true))
        case .roundedSmallSelected:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxSelected, imageColorType: .greenPositive, fontColorType: .blackBodyText, fontType: .regular15, imageSize: .small)
        case .roundedSmallDeselected:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxDeselected, imageColorType: .grayTertiaryText, fontColorType: .grayTertiaryText, fontType: .regular15, imageSize: .small)
        case .roundedLargeSelected:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxSelected, imageColorType: .greenPositive, fontColorType: .blackBodyText, fontType: .regular15, imageSize: .large)
        case .roundedLargeDeselected:
            return PagoCheckboxStyle(imageType: .roundedCheckBoxDeselected, imageColorType: .grayTertiaryText, fontColorType: .grayTertiaryText, fontType: .regular15, imageSize: .large)
        case .squareSmallSelected:
            return PagoCheckboxStyle(imageType: .checkBoxSelected, imageColorType: .greenPositive, fontColorType: .blackBodyText, fontType: .regular15, imageSize: .small)
        case .squareSmallDeselected:
            return PagoCheckboxStyle(imageType: .checkBoxDeselected, imageColorType: .grayTertiaryText, fontColorType: .grayTertiaryText, fontType: .regular15, imageSize: .small)
        case .squareLargeSelected:
            return PagoCheckboxStyle(imageType: .checkBoxSelected, imageColorType: .greenPositive, fontColorType: .blackBodyText, fontType: .regular15, imageSize: .large)
        case .squareLargeDeselected:
            return PagoCheckboxStyle(imageType: .checkBoxDeselected, imageColorType: .grayTertiaryText, fontColorType: .grayTertiaryText, fontType: .regular15, imageSize: .large)
        }
    }
    
}
