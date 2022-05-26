//
//  
//  PagoLoadedImagePresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol PagoLoadedImageViewPresenterView: PresenterView {
    func setup(backend: BackendImage)
    func setup(data: Data)
    func setup(image: UIImage.Pago)
    func setup(labelPlaceholder: PagoLabelPresenter)
}

open class PagoLoadedImageViewPresenter: BasePresenter {

    public var model: PagoLoadedImageViewModel {
       return (self.baseModel as! PagoLoadedImageViewModel)
    }
    public var accessibility: PagoAccessibility { return model.accessibility }
    public var style: PagoImageViewStyle { return model.style }
    private var view: PagoLoadedImageViewPresenterView? { return basePresenterView as? PagoLoadedImageViewPresenterView }
    
    internal func loadData() {
        
        switch model.imageData {
        case is BackendImage:
            let imageURL: String = (model.imageData as! BackendImage).url
            let imagePlaceholder: String = (model.imageData as! BackendImage).placeholderImageName
            let backend = BackendImage(url: imageURL, placeholderImageName: imagePlaceholder)
            view?.setup(backend: backend)
        case is DataImage:
            view?.setup(data: (model.imageData as! DataImage).data)
        case is PagoImage:
            view?.setup(image: (model.imageData as! PagoImage).image)
        case is PlaceholderLabelImage:
            let labelModel = (model.imageData as! PlaceholderLabelImage).label
            let labelPresenter = PagoLabelPresenter(model: labelModel)
            view?.setup(labelPlaceholder: labelPresenter)
        default:
            break
        }
    }
}
