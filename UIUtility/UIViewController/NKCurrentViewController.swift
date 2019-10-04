//
//  NKCurrentViewController.swift
//  UIUtility
//
//  Created by 草間寛啓 on 2019/10/04.
//  Copyright © 2019 nobuharu kusama. All rights reserved.
//

import UIKit

public protocol NKCurrentViewController where Self: UIViewController {
    var currentViewController: UIViewController? { get }
    func findCurrentViewController(viewController vc: UIViewController?) -> UIViewController?
}


extension NKCurrentViewController {
    
    var currentViewController: UIViewController? {
        return self.findCurrentViewController()
    }
    func findCurrentViewController(viewController vc: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        guard let base: UIViewController = vc else {
            return nil
        }
        switch base {
        case is UINavigationController:
            return self.findCurrentViewController(viewController: (base as! UINavigationController).topViewController)
        case is UITabBarController:
            return self.findCurrentViewController(viewController: (base as! UITabBarController).selectedViewController)
        default:
            break
        }
        if let presented: UIViewController = base.presentedViewController {
            return self.findCurrentViewController(viewController: presented)
        }
        return base
    }
}
