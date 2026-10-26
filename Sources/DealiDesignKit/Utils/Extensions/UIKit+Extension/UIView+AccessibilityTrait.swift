//
//  UIView+AccessibilityTrait.swift
//
//
//  Created by 이남준 on 10/22/26.
//

import UIKit

/**
 설명: accessibilityTraits에 특정 trait를 넣거나 빼는 helper. 다른 trait는 건드리지 않는다.
 */
extension UIView {
    func setAccessibilityTrait(_ trait: UIAccessibilityTraits, isOn: Bool) {
        if isOn {
            self.accessibilityTraits.insert(trait)
        } else {
            self.accessibilityTraits.remove(trait)
        }
    }
}
