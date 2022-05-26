//
//  
//  PagoWebView.swift
//  Pago
//
//  Created by Gabi Chiosa on 05.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import WebKit

open class PagoWebView: BaseView {
            
    public var webview: WKWebView!
    private var container: PagoView!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var loadingView: PagoAnimationView!
    private var loadingContainerView: PagoView!
    private let iOSmessageHandlerJSScript = "iOSmessageHandler999JSScript"

    private var presenterView: PagoWebPresenter! {
        return (presenter as! PagoWebPresenter)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public init(presenter: PagoWebPresenter) {
        
        super.init(frame: .zero)
        setupUI()
        presenter.setView(mView: self)
        setup(presenter: presenter)
    }
    
    public func setup(presenter: PagoWebPresenter) {
        
        self.presenter = presenter
        self.presenter.setView(mView: self)
        presenterView.loadData()
    }
    

    private func setupUI() {
        
        container = PagoView()
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        leadingConstraint = container.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        leadingConstraint.isActive = true
        trailingConstraint = self.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        trailingConstraint.isActive = true
        topConstraint = container.topAnchor.constraint(equalTo: self.topAnchor)
        topConstraint.isActive = true
        bottomConstraint = self.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.isActive = true
        
        webview = WKWebView()
        webview.configuration.userContentController.add(self, name: iOSmessageHandlerJSScript)
        webview.navigationDelegate = self
        webview.backgroundColor = .clear
        webview.isOpaque = false
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(webview)
        webview.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        webview.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
    
    deinit {
        
        webview.stopLoading()
    }
}

extension PagoWebView: PagoWebPresenterView {
    
    public func hideView(isHidden: Bool) {
        
        self.isHidden = isHidden
    }
    
    public func load(request: URLRequest) {
        
        webview.load(request)
    }

    public func setup(loader: PagoAnimationPresenter) {
        
        loadingContainerView = PagoView()
        loadingContainerView.backgroundColor = .white
        loadingContainerView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(loadingContainerView)
        loadingContainerView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        loadingContainerView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        loadingContainerView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        loadingContainerView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        loadingView = PagoAnimationView(presenter: loader)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingContainerView.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: loadingContainerView.centerYAnchor).isActive = true
    }
    
    public func showLoader() {
        
        loadingContainerView.isHidden = false
    }
    
    public func hideLoader() {
        
        loadingContainerView.isHidden = true
    }
}



extension PagoWebView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        presenterView.didReceiveServerRedirectForProvisionalNavigation(url: webView.url)
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        presenterView.didFinish(url: webView.url)
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        presenterView.decidePolicy(forURL: webView.url, decisionHandler: decisionHandler)
    }
}

extension PagoWebView: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard message.name == iOSmessageHandlerJSScript, let dict = message.body as? [String: AnyObject], let param = dict["state"] as? String else { return }
        
        presenterView.javascriptCallBack(state: param)
    }
}
