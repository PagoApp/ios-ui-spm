//
//  UIViewController+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 16/01/17.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    enum StoryboardName: String {
        case main = "Main",
            faq = "FAQ",
            development = "Development",
            settings = "SettingsStoryboard",
            feedback = "FeedbackStoryboard",
            freemium = "Freemium",
            referral = "ReferralStoryboard",
            card = "CardStoryboard",
            donate = "Donate",
            taxesFees = "TaxesFees",
            providers = "ProvidersStoryboard"
    }
    
    convenience init(bundle: Bundle?) {
        self.init(nibName: String(describing: type(of: self)), bundle: bundle)
    }
    
    class func fromMainStoryboard() -> Self {
        return fromStoryboard(.main)
    }
    
    class func fromSettingsStoryboard() -> Self {
        return fromStoryboard(.settings)
    }
    
    class func fromReferralStoryboard() -> Self {
        return fromStoryboard(.referral)
    }

    class func fromFeedbackStoryboard() -> Self {
        return fromStoryboard(.feedback)
    }

    class func fromFreemiumStoryboard() -> Self {
        return fromStoryboard(.freemium)
    }
    
    class func fromDonateStoryboard() -> Self {
        return fromStoryboard(.donate)
    }

    class func fromCardStoryboard() -> Self {
        return fromStoryboard(.card)
    }
    
    class func fromTaxesFeesStoryboard() -> Self {
        return fromStoryboard(.taxesFees)
    }

    class func fromStoryboard(_ name: StoryboardName) -> Self {
        return instantiateFromStoryboard(named: name.rawValue)
    }
    
    class func fromStoryboard(named name: String) -> Self {
        return instantiateFromStoryboard(named: name)
    }
    
    private class func instantiateFromStoryboard<T>(named name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    class func fromNib() -> Self {
        return instantiateFromNib()
    }
    
    class func instantiateFromNib<T>() -> T where T: UIViewController {
        return T.init(nibName: String(describing: T.self), bundle: nil)
    }
    
    func isVisible() -> Bool {
        return (isViewLoaded && view.window != nil)
    }
    
}

public extension BaseViewController {
    static func instantiateFromStoryboard(named name: StoryboardName, presenter: ViewControllerPresenter) -> Self {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! BaseViewController
        vc.basePresenter = presenter
        return vc as! Self
    }
}

public protocol NavigationBarSetup {
}

//extension NavigationBarSetup where Self: UIViewController {
//    
//    func setupNavigationBarBackButton() {
//        let backButton = UIBarButtonItem()
//        backButton.title = TextProvider.shared.getDefaultText(forElementWithId: "f55edb45-916c-42a4-8e2f-63bb36c7cb68")
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//    }
//    
//    func setupNavigationBarStyle(barTintColor: UIColor = UIColor.white, tintColor: UIColor = UIColor.black, barStyle: UIBarStyle = .black) {
//        navigationController?.navigationBar.update(bgColor: barTintColor, tintColor: tintColor)
//    }
//    
//    func resetNavigationBarStyle(barTintColor: UIColor = UIColor.white, tintColor: UIColor = UIColor.black, barStyle: UIBarStyle = .default) {
//        navigationController?.navigationBar.update(bgColor: barTintColor, tintColor: tintColor)
//    }
//}

public extension UIViewController {
    func getTheParentInsideTheNavigationController() -> UIViewController? {
        guard let navigationController = self.navigationController else {return nil}
        if navigationController.viewControllers.contains(self) {
            return self
        } else {
            return self.parent?.getTheParentInsideTheNavigationController()
        }
    }
}

@nonobjc public extension UIViewController {
    func addChild(_ child: UIViewController, container: UIView, frame: CGRect? = nil) {
        child.view.frame = frame != nil ? frame! : container.frame
        container.addSubview(child.view)
        addChildViewController(child)
        child.didMove(toParentViewController: self)
    }
    
    func removeAsChild() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
