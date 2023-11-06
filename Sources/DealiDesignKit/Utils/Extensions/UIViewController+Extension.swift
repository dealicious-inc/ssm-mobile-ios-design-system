//
//  UIViewController+Extension.swift
//
//
//  Created by JohyeonYoon on 11/6/23.
//

import UIKit

extension UIViewController {
    var isModal: Bool {
        if (self.presentingViewController != nil) {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentingViewController == self.navigationController {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}
