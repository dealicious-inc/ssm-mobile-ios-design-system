//
//  DealiFont.swift
//
//
//  Created by JohyeonYoon on 2023/04/17.
//

import UIKit

enum DealiFont {
    case h1
    case h2
    case sh1
    case sh2
    case sh3
    case b1
    case b2
    case b3
    case b4
    
    var style: DealiFontProperty.Style {
        switch self {
        case .h1:
            return DealiFontProperty.h1
        case .h2:
            return DealiFontProperty.h2
        default:
            return DealiFontProperty.b4
        }
    }
    
    var font: UIFont {
        let fontDescriptor = DealiFontProperty.fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.bold]])
        let font = UIFont(descriptor: fontDescriptor, size: self.style.size)
        font.dealiLineHeight = self.style.lineHeight
        
        return font
    }
}

struct DealiFontProperty {
    struct Style {
        let size: CGFloat
        let lineHeight: CGFloat
    }
    
    static let h1 = Style(size: 32.0, lineHeight: 40.0)
    static let h2 = Style(size: 28.0, lineHeight: 36.0)
    static let sh1 = Style(size: 20.0, lineHeight: 60.0)
    static let sh2 = Style(size: 18.0, lineHeight: 30.0)
    static let sh3 = Style(size: 16.0, lineHeight: 28.0)
    static let b1 = Style(size: 14.0, lineHeight: 28.0)
    static let b2 = Style(size: 12.0, lineHeight: 20.0)
    static let b3 = Style(size: 10.0, lineHeight: 18.0)
    static let b4 = Style(size: 8.0, lineHeight: 14.0)
    
    static let fontDescriptor = UIFontDescriptor.dealiFontDescriptor
}

extension UIFontDescriptor {
    static let dealiFontDescriptor: UIFontDescriptor = {
        return UIFontDescriptor().addingAttributes([.family: "Pretendard JP"])
    }()
}
