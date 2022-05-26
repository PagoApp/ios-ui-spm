//
//  
//  PagoNavigationModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 29/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

public enum PagoNavigationType {
    case none, simple, detailed, simpleSearchable, detailedSearchable
}

public struct PagoNavigationModel: Model {
    
    public var title: String? = ""
    public var shortTitle: String? = ""
    public var detail: String? = ""
    public var image: String? = ""
    public var backendImage: BackendImage?
    public var searchPlaceholder: String? = ""
    public var search: String? = ""
    public let type: PagoNavigationType
    public var isSnapping: Bool = false
    public var style = PagoNavigationStyle()
    public var hidesBackButton: Bool = false
    public var rightButtons: [PagoButtonModel]?
    
    public init(title: String? = "", shortTitle: String? = "", detail: String? = "", image: String? = "", backendImage: BackendImage? = nil, searchPlaceholder: String? = "", search: String? = "", type: PagoNavigationType, isSnapping: Bool = false, style: PagoNavigationStyle = PagoNavigationStyle(), hidesBackButton: Bool = false, rightButtons: [PagoButtonModel]? = nil) {
        
        self.title = title
        self.shortTitle = shortTitle
        self.detail = detail
        self.image = image
        self.backendImage = backendImage
        self.searchPlaceholder = searchPlaceholder
        self.search = search
        self.type = type
        self.isSnapping = isSnapping
        self.style = style
        self.hidesBackButton = hidesBackButton
        self.rightButtons = rightButtons
    }
}

public struct PagoNavigationStyle {
    
    public var textAlignment: NSTextAlignment = .left
    public var titleColor: UIColor.Pago = .blackBodyText
    public var titleSize = Float(34)
    public var detailSize = Float(16)
    public let searchSize = Float(44)
    public let breathSpace = Float(16)
    public var backgroundColor: UIColor.Pago = .white
    
    public init(textAlignment: NSTextAlignment = .left, titleColor: UIColor.Pago = .blackBodyText, titleSize: Float = Float(34), detailSize: Float = Float(16), backgroundColor: UIColor.Pago = .white) {
        
        self.textAlignment = textAlignment
        self.titleColor = titleColor
        self.titleSize = titleSize
        self.detailSize = detailSize
        self.backgroundColor = backgroundColor
    }
}
