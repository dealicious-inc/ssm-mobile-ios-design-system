//
//  UIFont+Extension.swift
//  
//
//  Created by 윤조현 on 2023/04/26.
//

import UIKit


public extension UIFont {
    static let h1b32: UIFont = DealiFont.h1Bold.systemFont
    
    static let h2b24: UIFont = DealiFont.h2Bold.systemFont
    
    static let sh1b20: UIFont = DealiFont.sh1Bold.systemFont
    static let sh1m20: UIFont = DealiFont.sh1Medium.systemFont
    
    static let sh2b18: UIFont = DealiFont.sh2Bold.systemFont
    static let sh2r18: UIFont = DealiFont.sh2Regular.systemFont
    
    static let sh3b16: UIFont = DealiFont.sh3Bold.systemFont
    static let sh3r16: UIFont = DealiFont.sh3Regular.systemFont
    
    static let b1sb15: UIFont = DealiFont.b1SemiBold.systemFont
    static let b1r15: UIFont = DealiFont.b1Regular.systemFont
    
    static let b2sb14: UIFont = DealiFont.b2SemiBold.systemFont
    static let b2r14: UIFont = DealiFont.b2Regular.systemFont

    static let b3sb13: UIFont = DealiFont.b3SemiBold.systemFont
    static let b3r13: UIFont = DealiFont.b3Regular.systemFont
   
    static let b4sb12: UIFont = DealiFont.b4SemiBold.systemFont
    static let b4r12: UIFont = DealiFont.b4Regular.systemFont

    static let c1b10: UIFont = DealiFont.c1Bold.systemFont
    static let c1r10: UIFont = DealiFont.c1Regular.systemFont
}

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
