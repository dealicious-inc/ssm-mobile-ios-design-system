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
    
    static let h1Bold: UIFont = { return DealiFont.h1.font.bold }()
    
    static let h2Bold: UIFont = { return DealiFont.h2.font.bold }()
    
    static let sh1Bold: UIFont = { return DealiFont.sh1.font.bold }()
    static let sh1Medium: UIFont = { return DealiFont.sh1.font.medium }()
    
    static let sh2Bold: UIFont = { return DealiFont.sh2.font.bold }()
    static let sh2Regular: UIFont = { return DealiFont.sh2.font.regular }()
    
    static let sh3Bold: UIFont = { return DealiFont.sh3.font.bold }()
    static let sh3Regular: UIFont = { return DealiFont.sh3.font.regular }()
    
    static let b1Bold: UIFont = { return DealiFont.b1.font.bold }()
    static let b1Regular: UIFont = { return DealiFont.b1.font.regular }()
    
    static let b2Bold: UIFont = { return DealiFont.b2.font.bold }()
    static let b2Medium: UIFont = { return DealiFont.b2.font.medium }()
    static let b2Regular: UIFont = { return DealiFont.b2.font.regular }()
    
    static let b3Bold: UIFont = { return DealiFont.b3.font.bold }()
    static let b3Medium: UIFont = { return DealiFont.b3.font.medium }()
    static let b3Regular: UIFont = { return DealiFont.b3.font.regular }()
    
    static let b4Bold: UIFont = { return DealiFont.b4.font.bold }()
    static let b4Medium: UIFont = { return DealiFont.b4.font.medium }()
    static let b4Regular: UIFont = { return DealiFont.b4.font.regular }()
    
    static let c1Bold: UIFont = { return DealiFont.c1.font.bold }()
    static let c1Regular: UIFont = { return DealiFont.c1.font.regular }()
}

fileprivate extension UIFont {
    var regular: UIFont { return withWeight(.regular) }
    var medium: UIFont { return withWeight(.medium) }
    var bold: UIFont { return withWeight(.bold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        let font = UIFont(descriptor: descriptor, size: pointSize)
        font.dealiLineHeight = self.dealiLineHeight
        return font
    }
}
