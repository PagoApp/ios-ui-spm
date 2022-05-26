//
//  BaseTextField.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

protocol BaseTextFieldDelegate: class {
    func deleteBackward()
}

class BaseTextField: UITextField {
    
    weak var baseDelegate: BaseTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        baseDelegate?.deleteBackward()
    }
}
