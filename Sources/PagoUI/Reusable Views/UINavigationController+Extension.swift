//
//  UINavigationController+Extension.swift
//  Pago
//
//  Created by Gabi Chiosa on 23.02.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func removeController(of type: AnyClass) {
        
        if let controller = self.viewControllers.first(where: {$0.isKind(of: type)}), let index = self.viewControllers.index(of: controller) {
            
            if index < self.viewControllers.count - 1 {
                self.viewControllers.remove(at: index)
            }
        }
    }
    
    var topBaseViewController: BaseViewController? {
        return topViewController as? BaseViewController
    }
    
    func showLoading() {
        
        DispatchQueue.main.async { [weak self] in
            self?.topBaseViewController?.showLoadingView()
        }
    }
    
    func hideLoading() {
        
        DispatchQueue.main.async { [weak self] in
            self?.topBaseViewController?.hideLoadingView()
        }
    }
    

    private func doAfterAnimatingTransition(animated: Bool, completion: @escaping (() -> Void)) {
        if let coordinator = transitionCoordinator, animated {
          coordinator.animate(alongsideTransition: nil, completion: { _ in
            completion()
          })
        } else {
          DispatchQueue.main.async {
            completion()
          }
        }
    }

    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping (() -> Void)) {
        pushViewController(viewController, animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }

    func popViewController(animated: Bool, completion: @escaping (() -> Void)) {
        popViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }

    func popToRootViewController(animated: Bool, completion: @escaping (() -> Void)) {
        popToRootViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }
}
