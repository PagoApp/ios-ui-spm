//
//  NSAttributedString+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    static func toAttributes(font fontType: UIFont.Pago? = nil, color colorType: UIColor.Pago? = nil, underlined: Bool? = false, striked: Bool = false, strikeColor: UIColor.Pago = UIColor.Pago.blackBodyText, paragraphStyle: PagoParagraphStyle? = nil) -> [NSAttributedStringKey: Any] {
        
        var attributes = [NSAttributedStringKey: Any]()
        if let color = colorType?.color {
            attributes[.foregroundColor] = color
        }
        if let font = fontType?.font {
            attributes[.font] = font
            if let pStyle = paragraphStyle {
                let style = NSMutableParagraphStyle()
                style.alignment = pStyle.alignment
                style.lineBreakMode = pStyle.lineBreakMode
                if pStyle.zeroLineSpace {
                    let lineHeight = font.pointSize - font.ascender + font.capHeight
                    let offset = font.capHeight - font.ascender
                    style.maximumLineHeight = lineHeight
                    style.minimumLineHeight = lineHeight
                    attributes[.baselineOffset] = offset
                }
                attributes[.paragraphStyle] = style
            }
        }
        if let underlinedT = underlined, underlinedT == true {
            attributes[.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
        }
        
        if striked {
            attributes[.strikethroughStyle] = 2
            attributes[.strikethroughColor] = strikeColor.color
        }
        return attributes
    }
}
