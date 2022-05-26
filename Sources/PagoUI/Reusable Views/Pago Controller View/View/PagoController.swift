//
//  
//  PagoControllerView.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

protocol PagoControllerDelegate: class {
    // NOTE: Add communication between cell and view controller if needed
}

class PagoPageController: BasePageControl {
    
    
    var viewPresenter: PagoPageControllerPresenter! {
        return (presenter as! PagoPageControllerPresenter)
    }
    weak var delegate: PagoControllerDelegate?
    
    
    init(presenter: PagoPageControllerPresenter) {
        
        super.init(frame: .zero)
        self.presenter = presenter
        setup()
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    func setup(presenter: PagoPageControllerPresenter) {
        
        self.presenter = presenter
        setup()
    }

    private func setup() {
        
        viewPresenter.setView(mView: self)
        pageIndicatorTintColor = viewPresenter.indicatorColorType.color
        currentPageIndicatorTintColor = viewPresenter.currentIndicatorColorType.color
        //TODO: Fix this
//        divider.color = viewPresenter.dividerColorType.color
    }
    
    override func reloadView() {
        
        super.reloadView()
        currentPage = viewPresenter.currentIndex
    }
}
