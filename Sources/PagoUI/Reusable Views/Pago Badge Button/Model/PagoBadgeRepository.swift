//
//  PagoBadgeRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

open class PagoBadgeRepository: Repository {
    
    public func getData(predicate: Predicate) -> Model? {
        
        guard let predicate = predicate as? PagoBadgePredicate else { return nil }
        
        let badgeStyle = PagoLabelStyle(textColorType: predicate.textColor, fontType: .medium15, backgroundColorType: .clear, alignment: .center, numberOfLines: 1)
        let badgeModel = PagoLabelModel(text: predicate.text, style: badgeStyle)
        return PagoBadgeModel(badge: badgeModel)
    }
}
