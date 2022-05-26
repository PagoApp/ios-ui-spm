//
//  NSMutableAttributedString+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    
    func update(style: [String: [NSAttributedStringKey: Any]]) {
        style.keys.forEach({
            self.updateStyle(for: $0, attributes: style[$0])
        })
    }
    
    func updateStyle(for string: String, attributes: [NSAttributedStringKey: Any]?) {
        
        let range = (self.string as NSString).range(of: string, options: .caseInsensitive)
        if let attributesT = attributes {
            self.addAttributes(attributesT, range: range)
        }
    }
}
