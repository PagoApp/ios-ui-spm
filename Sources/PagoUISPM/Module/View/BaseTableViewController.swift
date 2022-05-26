//
//  BaseTableViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 29.07.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseTableViewScrollDelegate: class {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}

open class BaseTableViewController: BaseViewController {
    
    weak var scrollDelegate: BaseTableViewScrollDelegate?

    public var tableView: UITableView!
    public let refreshControl = UIRefreshControl()
    
    private var presenter: ViewControllerPresenter {
        return basePresenter
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        let margins = view.layoutMarginsGuide
        let navigationView = PagoNavigationView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableView = PagoTableView()
        tableView.keyboardDismissMode = .interactive
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        let scrollViewBottomConstraint = margins.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        scrollViewBottomConstraint.isActive = true
        self.navigationView = navigationView
        self.scrollViewBottomConstraint = scrollViewBottomConstraint
        self.navScrollView = tableView
        tableView.tableFooterView = UIView()
    }
    
    func setupPullToRefresh() {
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    open override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    open override func reloadData() {
        
        super.reloadData()
        presenter.reloadData()
    }
    
    @objc func refreshTableView() {
        
        presenter.reloadData()
    }
}

extension BaseTableViewController: BaseScrollableViewControllerPresenterView {
    
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
}

extension BaseTableViewController {
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        super.scrollViewDidScroll(scrollView)
        scrollDelegate?.scrollViewDidScroll(scrollView)
        
    }

    public override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        super.scrollViewWillBeginDecelerating(scrollView)
        scrollDelegate?.scrollViewWillBeginDecelerating(scrollView)
    }
    
    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        scrollDelegate?.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }

    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        super.scrollViewDidEndDecelerating(scrollView)
        scrollDelegate?.scrollViewDidEndDecelerating(scrollView)
    }
}
