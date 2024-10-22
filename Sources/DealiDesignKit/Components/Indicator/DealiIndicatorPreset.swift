//
//  DealiIndicatorPreset.swift
//  
//
//  Created by 이창호 on 4/17/24.
//

import UIKit

public enum DealiIndicatorPreset {
    case dots
    case dotsw
    case number1
    case number2
    case number3
    
    public var normalColor: UIColor {
        switch self {
        case .dots:
            return .g30
        case .number1:
            return .primary04
        default:
            return .w50
        }
    }
    
    public var selectColor: UIColor {
        switch self {
        case .dots:
            return .primary01
        default:
            return .primary04
        }
    }
    
    public var backgroundColor: UIColor {
        switch self {
        case .number2, .number3:
            return .b40
        default:
            return .clear
        }
    }
    
    public var contentPadding: CGFloat {
        switch self {
        case .number2, .number3:
            return 8.0
        default:
            return 0.0
        }
    }
    
    public var dotsSize: CGSize {
        switch self {
        case .dots, .dotsw:
            return CGSize(width: 6.0, height: 6.0)
        default:
            return .zero
        }
    }
    
    public var cornerRadius: CGFloat {
        switch self {
        case .dots, .dotsw:
            return 3.0
        case .number2:
            return 13.0
        case .number3:
            return 10.0
        default:
            return 0.0
        }
    }
    
    public var contentSpacing: CGFloat {
        switch self {
        case .dots, .dotsw, .number1:
            return 6.0
        default:
            return 2.0
        }
    }
    
    public var indicatorViewHeight: CGFloat {
        switch self {
        case .number1:
            return 18.0
        case .number2:
            return 26.0
        case .number3:
            return 20.0
        default:
            return 0.0
        }
    }
    
    public var normalFont: UIFont {
        return .b3r13
    }
    
    public var selectFont: UIFont {
        return .b3sb13
    }
}
