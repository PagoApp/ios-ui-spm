//
//  
//  PagoMenuButtonModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 07/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

open class PagoMenuRepository: Repository {
    
    internal let buttonStyle = PagoButtonStyle(font: .bold17, textColor: .blackBodyText, backgroundColor: .clear)

    internal func badgePredicate(from count: Int?) -> PagoBadgePredicate? {

        guard let countT = count else { return nil }
        let text = countT > 0 ? "\(countT)" : ""
        let badge = PagoBadgePredicate(text: text, textColor: .white, backgroundColor: .redNegative, position: .topRight)
        return badge
    }
    
    internal func buttonModel(from menuModel: PagoMenuButtonModel, index: Int) -> PagoButtonModel {
        
        let badge = badgePredicate(from: menuModel.badgeCount)
        let button = PagoButtonModel(title: menuModel.title, isEnabled: true, isSelfSized: false, index: index, style: buttonStyle, badge: badge)
        return button
    }
    
    internal func buttonModels(from menu: [PagoMenuButtonModel]) -> [PagoButtonModel] {
        
        var models = [PagoButtonModel]()
        for (i, button) in menu.enumerated() {
            let tempButtonModel = buttonModel(from: button, index: i)
            models.append(tempButtonModel)
        }
        return models
    }
}

public struct PagoMenuButtonModel: Model {
    public let title: String
    public var badgeCount: Int?
    
    public init(title: String, badgeCount: Int?) {
        
        self.title = title
        self.badgeCount = badgeCount
    }
}

public struct PagoMenuModel: Model {
    public let buttons: [PagoMenuButtonModel]
    public let style = PagoMenuStyle()

}

public struct PagoMenuStyle {
    
    public let inactiveLineColorType = UIColor.Pago.dividers
    public let activeLineColorType = UIColor.Pago.blueHighlight

}

public struct PagoMenuButtonStyle {
    
    public let fontType = UIFont.Pago.bold17
    public let colorType = UIColor.Pago.blackBodyText
}
