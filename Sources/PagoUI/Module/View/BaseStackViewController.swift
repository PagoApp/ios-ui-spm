//
//  BaseStackViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 29.07.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation
import UIKit

open class BaseStackViewController: BaseViewController {
    
    public var scrollView: PagoScrollView!
    public var stackView: PagoStackView!

    private var emptyScreen: PagoEmptyScreenView?
    private let refreshControl = UIRefreshControl()
    private(set) var leadingStackConstraint: NSLayoutConstraint?
    private(set) var trailingStackConstraint: NSLayoutConstraint?
    
    private var presenter: ViewControllerPresenter {
        return basePresenter
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pago.dividers.color
        scrollView = PagoScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        self.navScrollView = scrollView
        scrollView.keyboardDismissMode = .interactive
        
        let margins = view.layoutMarginsGuide
        
        let navigationView = PagoNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        let scrollViewBottomConstraint = margins.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        scrollViewBottomConstraint.isActive = true
        self.scrollViewBottomConstraint = scrollViewBottomConstraint
        self.navigationView = navigationView
        self.navScrollView = scrollView
        
        stackView = PagoStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        scrollView.addSubview(stackView)
        leadingStackConstraint = stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        leadingStackConstraint?.isActive = true
        trailingStackConstraint = stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        trailingStackConstraint?.isActive = true
        leadingStackConstraint?.constant = 16
        trailingStackConstraint?.constant = 16
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupEmptyScreen(presenter: EmptyScreenPresenter) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let emptyScreen = PagoEmptyScreenView.fromNib(presenter: presenter)
            emptyScreen.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(emptyScreen)
            emptyScreen.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
            emptyScreen.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
            emptyScreen.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
            emptyScreen.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
            emptyScreen.isHidden = true
            self.emptyScreen = emptyScreen
            self.view.layoutIfNeeded()
        }
    }
    
    func setupPullToRefresh() {
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    override func reloadData() {
        
        super.reloadData()
        presenter.reloadData()
    }
    
    @objc func refreshTableView() {
        
        presenter.reloadData()
    }
}

extension BaseStackViewController: BaseStackViewControllerPresenterView {
    
    public func showLoader() {
        
        DispatchQueue.main.async { [weak self] in
            self?.showLoadingView()
        }
    }
    
    public func hideLoader() {
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoadingView()
        }
    }
    
    open func showEmptyScreen() {

        DispatchQueue.main.async { [weak self] in
            self?.emptyScreen?.isHidden = false
        }
    }

    open func hideEmptyScreen() {
        
        DispatchQueue.main.async { [weak self] in
            self?.emptyScreen?.isHidden = true
        }
    }
}
