//
//  DealiControl+TextLink.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 12/9/24.
//

import Foundation

public extension DealiControl {
    
}


// MARK: - Size
enum TextLinkSizeType {
    case large
    case medium
    case small
    
    var size: TextLinkSize {
        switch self {
        case .large:
            return TextLinkSize(height: 20, font: .b1sb15)
        case .medium:
            return TextLinkSize(height: 20, font: .b2r14)
        case .small:
            return TextLinkSize(height: 18, font: .b3r13)
        }
    }
}


// MARK: - Style
enum TextLinkStyleType {
    // 네이밍은 textColor 를 따름
    case primary01

    var style: TextLinkStyle {
        switch self {
        case .primary01:
            return TextLinkStyle(
                colorProvider: TextLinkColors(
                    normal: TextLinkColor(textColor: .primary01, backgroundColor: .clear),
                    disabled: TextLinkColor(textColor: .g50, backgroundColor: .clear)
                )
            )
        }
    }
}
