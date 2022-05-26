//
//  
//  PagoWebPresenter.swift
//  Pago
//
//  Created by Gabi Chiosa on 05.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import WebKit

public protocol PagoWebPresenterView: PresenterView {
    
    func load(request: URLRequest)
    func setup(loader: PagoAnimationPresenter)
    func hideLoader()
    func showLoader()
    func hideView(isHidden: Bool)
}

public protocol PagoWebPresenterDelegate: AnyObject {
    func didReceiveServerRedirectForProvisionalNavigation(url: URL?)
    func didFinish(url: URL?)
    func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->())
    func didReceiveJSCallBack(state: String)
}

public extension PagoWebPresenterDelegate {
    func didReceiveServerRedirectForProvisionalNavigation(url: URL?) { }
    func didFinish(url: URL?) { }
    func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->()) { }
}

open class PagoWebPresenter: BasePresenter {

    public weak var delegate: PagoWebPresenterDelegate?
    
    private var view: PagoWebPresenterView? {
        return basePresenterView as? PagoWebPresenterView
    }
    public var model: PagoWebModel {
        get { (self.baseModel as! PagoWebModel) }
        set { baseModel = newValue }
    }
    public var isLoading: Bool {
        return loaderPresenter.isAnimating
    }
    private let service: PagoWebService = PagoWebService()
    private var loaderPresenter: PagoAnimationPresenter!
    
    public func loadData() {
        
        if let request = model.urlRequest {
            load(request: request)
        }
        
        loaderPresenter = PagoAnimationPresenter(model: model.loaderModel)
        view?.setup(loader: loaderPresenter)
    }

    private func load(request: URLRequest) {
            
        service.cleanCache()
        view?.load(request: request)
    }
    
    public var isHidden: Bool = false {
        didSet {
            view?.hideView(isHidden: isHidden)
        }
    }
    public func showLoader() {
        
        loaderPresenter.play()
        view?.showLoader()
    }
    
    public func hideLoader() {
        
        loaderPresenter.stop()
        view?.hideLoader()
    }
    
    public func restartWebView() {
        
        if let request = model.urlRequest {
            load(request: request)
        }
    }
    
    public func didReceiveServerRedirectForProvisionalNavigation(url: URL?) {
        
        delegate?.didReceiveServerRedirectForProvisionalNavigation(url: url)
    }
    
    public func didFinish(url: URL?) {
        
        delegate?.didFinish(url: url)
    }
    
    public func decidePolicy(forURL: URL?, decisionHandler: @escaping(WKNavigationActionPolicy)->()) {
     
        if delegate == nil {
            decisionHandler(.allow)
        } else {
            delegate?.decidePolicy(forURL: forURL, decisionHandler: decisionHandler)
        }
    }
    
    public func javascriptCallBack(state: String) {
     
        delegate?.didReceiveJSCallBack(state: state)
    }
}
