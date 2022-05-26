//
//  
//  PagoSearchBarModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 30/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public struct PagoSearchBarModel: Model {
    
    public var text: String?
    public var placeholder: String?
    public let style = PagoSearchBarStyle()
    
    public init(text: String? = nil, placeholder: String? = nil) {
        
        self.text = text
        self.placeholder = placeholder
    }
}

public struct PagoSearchBarStyle {
    
    public let cornerRadius = 8
    public let borderColor = UIColor.Pago.dividers
    public let borderWidth = 2
    public let backgroundColor = UIColor.Pago.white
    public let placeholderFont = UIFont.Pago.regular15
    public let placeholderTextColor = UIColor.Pago.lightGrayInactive
    public let searchFont = UIFont.Pago.regular15
    public let searchIndicatorColor = UIColor.Pago.lightGrayInactive
    public let searchTextColor = UIColor.Pago.blackBodyText
}
