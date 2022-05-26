//
//  BaseViewControllerT.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 05/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, ViewControllerPresenterView {

    public var basePresenter: ViewControllerPresenter!
    private var observation: NSKeyValueObservation?
    private var navImageView: UIImageView?
    private var navTitleLabel: UILabel?
    
    @IBOutlet var navScrollView: UIScrollView?
    @IBOutlet var navigationView: PagoNavigationView?
    @IBOutlet var scrollViewBottomConstraint: NSLayoutConstraint?
    
    var oldScroll = CGPoint.zero
    private var loadingOverlayContainer: PagoView?
    
    public convenience init(presenter: ViewControllerPresenter) {
        
        self.init()
        self.basePresenter = presenter
    }

    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.delegate = self
        view.backgroundColor = .white
    }
    

    func keyboardWillAppearUpdates() {}
    
    func keyboardWillDissappearUpdates() {}
    
    @objc func baseKeyboardWillChangeFrame(_ notification:Notification) {
    
        guard let scrollViewBottomConstraint = scrollViewBottomConstraint else { return }
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            var bottomSafeArea: CGFloat!
            if #available(iOS 11.0, *) {
                bottomSafeArea = view.safeAreaInsets.bottom
            } else {
                bottomSafeArea = bottomLayoutGuide.length
            }
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                guard scrollViewBottomConstraint.constant != 0.0 else { return }
                scrollViewBottomConstraint.constant = 0.0
                keyboardWillDissappearUpdates()
            } else if let height = endFrame?.size.height {
                keyboardWillAppearUpdates()
                scrollViewBottomConstraint.constant = (height - bottomSafeArea)
            } else {
                keyboardWillDissappearUpdates()
                scrollViewBottomConstraint.constant = 0.0
            }
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(baseKeyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        if self.isMovingFromParent {
            basePresenter.willPopScreen()
        }
    }

    func reloadData() {
        basePresenter.reloadData()
    }
    
    var rightBarButtonItems = [UIBarButtonItem]()
    
    func setupCustomNavigation(rightButtons: [PagoButtonPresenter]? = nil) {

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.text = basePresenter.navigationTitle
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = basePresenter.navigationTitleColor.color
        self.navTitleLabel = titleLabel
        
        let imageView = UIImageView()
        let imageName = basePresenter.navigationImage ?? ""
        imageView.image = imageName.isEmpty ? nil : UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        let contentView = UIView()
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.alpha = 0
        self.navImageView = imageView

        if !(basePresenter.navigationImage ?? "").isEmpty || !(basePresenter.navigationTitle ?? "").isEmpty {
            self.navigationItem.titleView = contentView
        }
        
        navScrollView?.delegate = self
        navScrollView?.alwaysBounceVertical = true
        
        if let image = basePresenter.navigationImage, !image.isEmpty {
            navImageView?.image = UIImage(named: image)
        } else if let bImage = basePresenter.navigationBackendImage {
            loadCustomNavigationImage(placeholder: bImage.placeholderImageName, url: bImage.url)
        }
        
        rightBarButtonItems.removeAll()
        
        if let images = rightButtons {
            for buttonPresenter in images.reversed() {
                let button = PagoButton(presenter: buttonPresenter)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 36).isActive = true
                button.widthAnchor.constraint(equalToConstant: 36).isActive = true
                let item = UIBarButtonItem(customView: button)
                rightBarButtonItems.append(item)
            }
        }
    }
    
    public func showOverlayLoading() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.loadingOverlayContainer?.removeFromSuperview()
            let loadingOverlayContainer = PagoView()
            loadingOverlayContainer.backgroundColor = .clear
            loadingOverlayContainer.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(loadingOverlayContainer)
            loadingOverlayContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            loadingOverlayContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            loadingOverlayContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            loadingOverlayContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.view.bringSubviewToFront(loadingOverlayContainer)
            self.loadingOverlayContainer = loadingOverlayContainer
            
            let animLoadingModel = PagoAnimationModel(animationType: .statusLoading, loop: true, style: PagoAnimationStyle(size: CGSize(width: 60, height: 60)))
            let animPresenter = PagoAnimationPresenter(model: animLoadingModel)
            let animView = PagoAnimationView(presenter: animPresenter)
            animView.translatesAutoresizingMaskIntoConstraints = false
            loadingOverlayContainer.addSubview(animView)
            animView.centerXAnchor.constraint(equalTo: loadingOverlayContainer.centerXAnchor).isActive = true
            animView.centerYAnchor.constraint(equalTo: loadingOverlayContainer.centerYAnchor).isActive = true
        }
        
    }
    
    public func hideOverlayLoading() {

        DispatchQueue.main.async { [weak self] in
            self?.loadingOverlayContainer?.removeFromSuperview()
            self?.loadingOverlayContainer = nil
        }
    }
    
    func loadCustomNavigationImage(placeholder: String = "", url: String) {
        
        let logoURL = URL(string: url)
        let placeholderImage = UIImage(named: placeholder)
        //TODO: Should fix this
//        navImageView?.sd_setImage(with: logoURL, placeholderImage: placeholderImage) { [weak self] (image, _, _, _) in
//            DispatchQueue.main.async {
//                guard let self = self, let image = image else {
//                    return
//                }
//                self.navImageView?.image = image
//            }
//        }
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    static func fromNib(presenter: ViewControllerPresenter) -> Self {
        let vc = fromNib()
        vc.basePresenter = presenter
        return vc
    }

    @objc open dynamic func didStartedLoading() {}
    @objc open dynamic func didFinishLoading() {}
    @objc open dynamic func reloadView() {}
    
    public func shouldShowTitle(_ showTitle: Bool) {

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            guard (self.navTitleLabel?.alpha != 1 && showTitle) ||
                    (self.navTitleLabel?.alpha != 0 && !showTitle) else { return }
            
            
            if showTitle {
                self.navTitleLabel?.text = self.basePresenter.navigationTitle
                if !self.rightBarButtonItems.isEmpty {
                    self.navigationItem.setRightBarButtonItems(self.rightBarButtonItems, animated: true)
                    self.navigationView?.hideRightButtons()
                }
            } else {
                if !self.rightBarButtonItems.isEmpty {
                    self.navigationItem.setRightBarButtonItems(nil, animated: true)
                    self.navigationView?.showRightButtons()
                }
            }
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.navImageView?.alpha = showTitle ? 0 : 1
                self.navTitleLabel?.alpha = showTitle ? 1 : 0
            }
        }
        
    }

    public func setupNavigation(presenter: PagoNavigationPresenter) {
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationView?.setup(presenter: presenter)
            self?.setupCustomNavigation(rightButtons: presenter.smallRightButtonsPresenters)
            self?.basePresenter.navigationViewDidLoad()
        }
    }
    
    public func snapNavigation(offset: Float?) {
        guard let offsetT = offset else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationView?.handleSnap(offset: CGFloat(offsetT), parent: self.view)
        }
    }
}

extension BaseViewController: UIScrollViewDelegate, BaseTableViewScrollDelegate {
    
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        basePresenter.isScrolling = true
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        basePresenter.isScrolling = true
        basePresenter.updateNavigationTitle()
        if let contentOffset = basePresenter.didScroll(y: Float(scrollView.contentOffset.y)) {
            scrollView.contentOffset.y = CGFloat(contentOffset)
        }
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        basePresenter.willBeginDecelerating()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if !decelerate {
            basePresenter.isScrolling = false
        }
        basePresenter.snapView()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        basePresenter.isScrolling = false
        basePresenter.snapView()
    }
}

extension BaseViewController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        /*
         TODO: If we want to display custom back title use below as starter condition
         prevTitle =  (prevController.basePresenter.isLargeTitleVisible ? " " : prevController.basePresenter.navigationTitle) ?? " "
         */
        let prevTitle: String = " "
        let navCount = navigationController.viewControllers.count
        if navCount >= 2 {
            let prevVC = navigationController.viewControllers[navCount-2]
            if basePresenter.hidesBackButton {
                navigationItem.hidesBackButton = true
            } else {
                let item = UIBarButtonItem(title: prevTitle, style: .plain, target: nil, action: nil)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Pago.blackBodyText.color, NSAttributedString.Key.font: UIFont.Pago.semiBold17.font], for: .normal)
                prevVC.navigationItem.backBarButtonItem = item
            }
        }
        
    }
}

extension UIScrollView {
    
    func updateContentSize(width: CGFloat = 0, height: CGFloat = 0) {
        
        let currentSize = self.contentSize
        let increasedSize = CGSize(width: currentSize.width + width, height: currentSize.height + height)
        self.contentSize = increasedSize
    }
}
