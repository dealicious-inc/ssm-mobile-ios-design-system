//
//  Font+SystemFont.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 10/29/25.
//

import SwiftUI

public extension Font {
    static let h1sb32: Font = Font(UIFont.h1sb32)
    static let h2sb24: Font = Font(UIFont.h2sb24)
    static let h3sb28: Font = Font(UIFont.h3sb28)
    static let sh1sb20: Font = Font(UIFont.sh1sb20)
    static let sh1r20: Font = Font(UIFont.sh1r20)
    static let sh2sb18: Font = Font(UIFont.sh2sb18)
    static let sh2r18: Font = Font(UIFont.sh2r18)
    static let sh3sb16: Font = Font(UIFont.sh3sb16)
    static let sh3r16: Font = Font(UIFont.sh3r16)
    
    static let b1sb15: Font = Font(UIFont.b1sb15)
    static let b1r15: Font = Font(UIFont.b1r15)
    
    static let b2sb14: Font = Font(UIFont.b2sb14)
    static let b2r14: Font = Font(UIFont.b2r14)
    
    static let b3sb13: Font = Font(UIFont.b3sb13)
    static let b3r13: Font = Font(UIFont.b3r13)
    
    static let b4sb12: Font = Font(UIFont.b4sb12)
    static let b4r12: Font = Font(UIFont.b4r12)
    
    static let c1sb10: Font = Font(UIFont.c1sb10)
    static let c1r10: Font = Font(UIFont.c1r10)
}

public extension Font {
    var lineHeight: CGFloat {
        return self.uiFont.dealiLineHeight
    }
    
    var uiFont: UIFont {
        switch self {
        case .h1sb32: return .h1sb32
        case .h2sb24: return .h2sb24
        case .h3sb28: return .h3sb28
        case .sh1sb20: return .sh1sb20
        case .sh1r20: return .sh1r20
        case .sh2sb18: return .sh2sb18
        case .sh2r18: return .sh2r18
        case .sh3sb16: return .sh3sb16
        case .sh3r16: return .sh3r16
        case .b1sb15: return .b1sb15
        case .b1r15: return .b1r15
        case .b2sb14: return .b2sb14
        case .b2r14: return .b2r14
        case .b3sb13: return .b3sb13
        case .b3r13: return .b3r13
        case .b4sb12: return .b4sb12
        case .b4r12: return .b4r12
        case .c1sb10: return .c1sb10
        case .c1r10: return .c1r10
        default: return .systemFont(ofSize: UIFont.labelFontSize)
        }
    }
}
