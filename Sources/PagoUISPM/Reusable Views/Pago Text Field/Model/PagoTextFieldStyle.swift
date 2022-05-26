//
//  PagoTextFieldStyle.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoTextFieldStyle {
    public var isTitleUppercased: Bool = true
    public var backgroundColor: UIColor.Pago = .white
    public let textAnimationDuration = 0.3
    public let textErrorColor = UIColor.Pago.redNegative
    public let textDetailColor = UIColor.Pago.grayTertiaryText
    public var titleColor = UIColor.Pago.grayTertiaryText
    public var placeholderColor = UIColor.Pago.grayTertiaryText
    public var textFieldColor = UIColor.Pago.blackBodyText
    public var textFieldInvalidColor = UIColor.Pago.redNegative
    public var textFieldDefaultLineColor = UIColor.Pago.dividers
    public var textFieldInvalidLineColor = UIColor.Pago.redNegative
    public var titleFont = UIFont.Pago.semiBold13
    public let detailFont = UIFont.Pago.regular13
    public var textFieldFont = UIFont.Pago.medium17
    public let textFieldOffset: CGFloat = 8
    public var textFieldContentType = UITextContentType(rawValue: "")
    public var textFieldAlignment: NSTextAlignment = .left
    public var detailNumberOfLines = 2
    public var autocapitalizationType: UITextAutocapitalizationType = .none
    public var keyboardType: UIKeyboardType = .default
    public var isSecureTextEntry: Bool = false
    public var isUserInteractionEnabled: Bool = true
    public var returnKeyType: UIReturnKeyType  = .next
    public var borderStyle: BorderStyle?
    public var isHidden: Bool = false
    public var titleSpace: CGFloat = 8
    public var toolbarButton: UIBarButtonSystemItem?
    public var datePickerStyle: PagoTextFieldDatePickerStyle? = nil
    
    public init(isTitleUppercased: Bool = true, backgroundColor: UIColor.Pago = .white, titleColor: UIColor.Pago = UIColor.Pago.grayTertiaryText, placeholderColor: UIColor.Pago = UIColor.Pago.grayTertiaryText, textFieldColor: UIColor.Pago = UIColor.Pago.blackBodyText, textFieldInvalidColor: UIColor.Pago = UIColor.Pago.redNegative, textFieldDefaultLineColor: UIColor.Pago = UIColor.Pago.dividers, textFieldInvalidLineColor: UIColor.Pago = UIColor.Pago.redNegative, titleFont: UIFont.Pago = UIFont.Pago.semiBold13, textFieldContentType: UITextContentType = UITextContentType(rawValue: ""), textFieldAlignment: NSTextAlignment = .left, detailNumberOfLines: Int = 2, autocapitalizationType: UITextAutocapitalizationType = .none, keyboardType: UIKeyboardType = .default, isSecureTextEntry: Bool = false, isUserInteractionEnabled: Bool = true, returnKeyType: UIReturnKeyType  = .next, borderStyle: BorderStyle? = nil, isHidden: Bool = false, titleSpace: CGFloat = 8, toolbarButton: UIBarButtonSystemItem? = nil, datePickerStyle: PagoTextFieldDatePickerStyle? = nil) {
        
        self.isTitleUppercased = isTitleUppercased
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.placeholderColor = placeholderColor
        self.textFieldColor = textFieldColor
        self.textFieldInvalidColor = textFieldInvalidColor
        self.textFieldDefaultLineColor = textFieldDefaultLineColor
        self.textFieldInvalidLineColor = textFieldInvalidLineColor
        self.titleFont = titleFont
        self.textFieldContentType = textFieldContentType
        self.textFieldAlignment = textFieldAlignment
        self.detailNumberOfLines = detailNumberOfLines
        self.autocapitalizationType = autocapitalizationType
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.returnKeyType = returnKeyType
        self.borderStyle = borderStyle
        self.isHidden = isHidden
        self.titleSpace = titleSpace
        self.toolbarButton = toolbarButton
        self.datePickerStyle = datePickerStyle
    }
}

public struct PagoTextFieldDatePickerStyle {
    public var current: Date = Date()
    public let minDate: Date?
    public let maxDate: Date?
    
    public init(current: Date = Date(), minDate: Date? = nil, maxDate: Date? = nil) {
        
        self.minDate = minDate
        self.maxDate = maxDate
        self.current = current
    }
}
