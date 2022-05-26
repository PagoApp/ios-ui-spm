//
//  
//  PagoControllerModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

struct PagoPageControllerModel: Model {
    
    let numberOfPages: Int
    var currentIndex = 0
    let style: PagoPageControllerStyle = PagoPageControllerStyle(indicatorColor: .lightGrayInactive, currentIndicatorColor: .greenPositive, dividerColor: .clear)
}


struct PagoPageControllerStyle {

    let indicatorColor: UIColor.Pago
    let currentIndicatorColor: UIColor.Pago
    let dividerColor: UIColor.Pago
}
