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
    
    // ver 01
    static let h1: UIFont = { return DealiFont.h1.font }()
    
    // ver 02
    static let sh1: UIFont = {
        let style = DealiFontProperty.sh1
        
        let fontDescriptor = DealiFontProperty.fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular]])
        let font = UIFont(descriptor: fontDescriptor, size: style.size)
        font.dealiLineHeight = style.lineHeight
        
        return font
    }()

    // ver 03
    static let b4: UIFont = {
        let fontDescriptor = UIFontDescriptor.dealiFontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular]])
        let font = UIFont(descriptor: fontDescriptor, size: 12.0)
        font.dealiLineHeight = 18.0
        
        return font
    }()
    
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


