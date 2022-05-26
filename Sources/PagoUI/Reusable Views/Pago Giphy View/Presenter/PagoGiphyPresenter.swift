//
//  
//  PagoGiphyPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 16.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
protocol PagoGiphyPresenterView: PresenterView {
    func isHidden(hidden: Bool)
    func setup(media: Any)
    func setup(close: PagoLoadedImageViewPresenter)
}

@available(iOS 13.0, *)
protocol PagoGiphyPresenterDelegate: AnyObject {
    func didDismissGiphy(presenter: PagoGiphyPresenter)
    func didLoadGif()
}

@available(iOS 13.0, *)
class PagoGiphyPresenter: BasePresenter {

    weak var delegate: PagoGiphyPresenterDelegate?
    var model: PagoGiphyModel { return (self.baseModel as! PagoGiphyModel) }
    var style: PagoGiphyStyle { return model.style }
    var loop: Bool { return model.loop }
    var mediaId: String { return model.mediaId }
    var accessibility: PagoAccessibility { return model.accessibility }
    var closePresenter: PagoButtonPresenter?
    var isDissmisable: Bool { return model.isDissmisable }
    public var aspectRatio: CGFloat? {
        didSet {
            if aspectRatio != nil {
                delegate?.didLoadGif()
            }
        }
    }
    private let service: PagoGiphyService = PagoGiphyService()
    private var view: PagoGiphyPresenterView? { return basePresenterView as? PagoGiphyPresenterView }
    
    public func hidden(_ hidden: Bool) {
        
        view?.isHidden(hidden: hidden)
    }
    
    public func loadData() {
        
        service.getGif(mediaId: mediaId) { [weak self] media in
            self?.view?.setup(media: media)
        }
        
        if model.isDissmisable {
            let imageStyle = PagoImageViewStyle(size: CGSize(width: 12, height: 12), inset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), tintColorType: .blueHighlight, backgroundColorType: .lightBlueBackground, backgroundCornerRadius: 14, borderStyle: BorderStyle(colorType: .white, width: 2))
            let imageModel = PagoLoadedImageViewModel(imageData: PagoImage(image: .close), style: imageStyle)
            let imagePresenter = PagoLoadedImageViewPresenter(model: imageModel)
            view?.setup(close: imagePresenter)
        }
    }
    
    func handleTap() {
        
        delegate?.didDismissGiphy(presenter: self)
    }

}
