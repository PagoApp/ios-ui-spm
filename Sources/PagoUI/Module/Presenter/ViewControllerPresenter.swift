//
//  ViewControllerPresenter.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 13/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public protocol BaseStackViewControllerPresenterView: BaseScrollableViewControllerPresenterView {
    
    func showEmptyScreen()
    func hideEmptyScreen()
}

public protocol BaseScrollableViewControllerPresenterView: ViewControllerPresenterView {
    
//    func showLoader()
//    func hideLoader()
}

public protocol ViewControllerPresenterView: PresenterView {
    
    func showOverlayLoading()
    func hideOverlayLoading()
    func didStartedLoading()
    func didFinishLoading()
    func setupNavigation(presenter: PagoNavigationPresenter)
    func shouldShowTitle(_ showTitle: Bool)
    func snapNavigation(offset: Float?)
}

open class ViewControllerPresenter: BasePresenter {
    
    public var baseRepository: Repository?
    private var isSearching: Bool = false
    let navigationPresenter: PagoNavigationPresenter
    enum Direction {
        case collapse, expand, none
    }
    var scrollDirection: Direction = .none
    var scrollViewOldContentOffsetY = Float(0)
    var navigationTitleColor: UIColor.Pago { return navigationPresenter.titleColor }
    var navigationTitle: String? { return navigationPresenter.shortTitle }
    var navigationImage: String? { return navigationPresenter.image }
    var navigationBackendImage: BackendImage? { return navigationPresenter.backendImage }
    var isLargeTitleVisible: Bool { return navigationPresenter.isTitleVisible }
    var hidesBackButton: Bool { return navigationPresenter.hidesBackButton }
    var isPendingMode: Bool = false
    var isScrolling: Bool = false
    
    private var view: ViewControllerPresenterView? { return basePresenterView as? ViewControllerPresenterView }
    
    public init(navigation: PagoNavigationPresenter, model: Model = EmptyModel()) {
        
        self.navigationPresenter = navigation
        super.init(model: model)
        self.navigationPresenter.delegate = self
    }
    
    override init(model: Model = EmptyModel()) {
        self.navigationPresenter = PagoNavigationPresenter(model: PagoNavigationModel(type: .none))
        super.init(model: model)
    }
    
    open func loadData() {
        
        self.view?.setupNavigation(presenter: navigationPresenter)
        if navigationPresenter.type == .none {
            view?.shouldShowTitle(true)
        }
    }
    
    public func willPopScreen() {
        //NOTE: Override this method to know when user pops current screen
    }

    open func reloadData() {
        //NOTE: Override this method to reload ui where neccessary
    }
    
    public func enableNavigationButtons() {
        
        navigationPresenter.enableButtons()
    }
    
    public func disableNavigationButtons() {
        
        navigationPresenter.disableButtons()
    }
    
    func enterSearchMode() {
        
        guard navigationPresenter.isSearchable else { return }
        isSearching = true
        navigationPresenter.startSearch()
        view?.snapNavigation(offset: navigationPresenter.searchModeSize)
        view?.shouldShowTitle(true)
        
    }
    
    func exitSearchMode() {
        
        guard navigationPresenter.isSearchable else { return }
        isSearching = false
        navigationPresenter.stopSearch()
        view?.snapNavigation(offset: navigationPresenter.size)
        view?.shouldShowTitle(!isLargeTitleVisible)
    }
    
    func updateNavigationTitle() {
        
        view?.shouldShowTitle(!isLargeTitleVisible)
    }

    func canSnap(contentOffset: Float) -> Bool {
        
        return (navigationPresenter.offset > 0 || contentOffset <= 0) && navigationPresenter.isSnapping && !navigationPresenter.isSearching
    }
    
    func didScroll(y scrollViewY: Float) -> Float? {
        
        guard canSnap(contentOffset: scrollViewY) else { return nil }
        
        var scrollViewContentOffsetY = scrollViewY
        let delta =  scrollViewContentOffsetY - scrollViewOldContentOffsetY
        //we compress the top view
        if delta > 0 && navigationPresenter.offset > 0 && scrollViewContentOffsetY > 0 {
            navigationPresenter.update(offset: max(0, navigationPresenter.offset - delta))
            scrollViewContentOffsetY -= delta
            scrollDirection = .collapse
        }

        //we expand the top view
        if delta < 0 && navigationPresenter.offset < navigationPresenter.size && scrollViewContentOffsetY < 0 {
            navigationPresenter.update(offset: min(navigationPresenter.offset - delta, navigationPresenter.size))
            scrollViewContentOffsetY -= delta
            scrollDirection = .expand
        }
        return scrollViewContentOffsetY
    }
    
    func willBeginDecelerating() {
        
        guard navigationPresenter.isHidden == false, navigationPresenter.isSnapping && !navigationPresenter.isSearching else { return }

        if navigationPresenter.offset <= navigationPresenter.size {
            snapView()
        }
    }

    func snapView() {
        
        guard navigationPresenter.isHidden == false, navigationPresenter.isSnapping && !navigationPresenter.isSearching else { return }
        
        let snapOffset = navigationPresenter.handleSnap(isCollapsing: scrollDirection == .collapse)
        view?.snapNavigation(offset: snapOffset)
        scrollDirection = .none
    }
    
    func navigationViewDidLoad() {}
    
    func setNavigationRightButtonsDelegate(_ delegate: PagoButtonPresenterDelegate) {
        navigationPresenter.smallRightButtonsPresenters.forEach({$0.delegate = delegate})
        navigationPresenter.largeRightButtonsPresenters.forEach({$0.delegate = delegate})
    }

}

extension ViewControllerPresenter: PagoNavigationPresenterDelegate {
    
    @objc public func didUpdateTitleVisibility(isVisible: Bool) {
        
        guard !isSearching else { return }
        view?.shouldShowTitle(!isVisible)
    }
    
    @objc public func didSetupNavigation() {}
}

open class EmptyModel: Model {
    
    public init() {
        
    }
}
