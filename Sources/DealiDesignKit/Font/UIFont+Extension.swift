//
//  UIFont+Extension.swift
//  
//
//  Created by 윤조현 on 2023/04/26.
//

import UIKit

public extension UIFont {
    
    private struct AssociatedKeys {
        static var dealiLineHeight = "dealiLineHeight"
    }
    
    var dealiLineHeight: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.dealiLineHeight) as? CGFloat
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.dealiLineHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension UIFont {
    static let h1Bold: UIFont = { return DealiFont.h1Bold.font }()
    
    static let h2Bold: UIFont = { return DealiFont.h2Bold.font }()
    
    static let sh1Bold: UIFont = { return DealiFont.sh1Bold.font }()
    static let sh1Medium: UIFont = { return DealiFont.sh1Medium.font }()
    
    static let sh2Bold: UIFont = { return DealiFont.sh2Bold.font }()
    static let sh2Regular: UIFont = { return DealiFont.sh2Regular.font }()
    
    static let sh3Bold: UIFont = { return DealiFont.sh3Bold.font }()
    static let sh3Regular: UIFont = { return DealiFont.sh3Regular.font }()
    
    static let b1Bold: UIFont = { return DealiFont.b1Bold.font }()
    static let b1Regular: UIFont = { return DealiFont.b1Regular.font }()
    
    static let b2Bold: UIFont = { return DealiFont.b2Bold.font }()
    static let b2Medium: UIFont = { return DealiFont.b2Medium.font }()
    static let b2Regular: UIFont = { return DealiFont.b2Regular.font }()
    
    static let b3Bold: UIFont = { return DealiFont.b3Bold.font }()
    static let b3Medium: UIFont = { return DealiFont.b3Medium.font }()
    static let b3Regular: UIFont = { return DealiFont.b3Regulr.font }()
    
    static let b4Bold: UIFont = { return DealiFont.b4Bold.font }()
    static let b4Medium: UIFont = { return DealiFont.b4Medium.font }()
    static let b4Regular: UIFont = { return DealiFont.b4Regular.font }()
    
    static let c1Bold: UIFont = { return DealiFont.c1Bold.font }()
    static let c1Regular: UIFont = { return DealiFont.c1Regular.font }()
}

