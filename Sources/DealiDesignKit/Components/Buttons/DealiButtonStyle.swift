//
//  DealiButtonStyle.swift
//
//
//  Created by 윤조현 on 2023/06/26.
//

import UIKit

public indirect enum DealiButtonStyle: Equatable {
    case large(style: DealiButtonStyle)
    case medium(style: DealiButtonStyle)
    case small(style: DealiButtonStyle)
    
    case filled
    case outlined
    case tonal
    case text
    
    var baseStyle: DealiButtonStyle {
        switch self {
        case .large(let style), .medium(let style), .small(let style):
            return style
        default:
            return self
        }
    }
    
    // MARK: BackgroundColor
    var defaultBackgroundColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.primary01
        case .tonal:
            return DealiColor.bg07
        default:
            return DealiColor.primary04
        }
    }
    
    var pressedBackgroundColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.primary02
        case .tonal:
            return DealiColor.bg07
        default:
            return DealiColor.primary04
        }
    }
    
    var disabledBackgroundColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.bg04
        case .tonal:
            return DealiColor.bg07
        default:
            return DealiColor.primary04
        }
    }
    
    // MARK: TextColor
    var textColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.primary04
        case .outlined:
            return DealiColor.primary01
        case .tonal:
            return DealiColor.text02
        default:
            return DealiColor.text02
        }
    }
    
    var disabledTextColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.primary04
        default:
            return DealiColor.text05
        }
    }
    
    var pressedTextColor: UIColor {
        switch self.baseStyle {
        case .filled:
            return DealiColor.primary04
        case .outlined:
            return DealiColor.primary01
        case .tonal, .text:
            return DealiColor.text01
        default:
            return DealiColor.text01
        }
    }
    
    var hasBorder: Bool {
        self.baseStyle == .outlined || self.baseStyle == .tonal
    }
    
    var defaultBorderColor: CGColor {
        switch self.baseStyle {
        case .outlined:
            return DealiColor.primary01.cgColor
        case .tonal:
            return DealiColor.line03.cgColor
        default:
            return DealiColor.primary04.cgColor
        }
    }
    
    var disabledBorderColor: CGColor {
        switch self.baseStyle {
        case .outlined, .tonal:
            return DealiColor.line03.cgColor
        default:
            return DealiColor.primary04.cgColor
        }
    }
    
    var font: UIFont {
        switch self {
        case .large(_):
            return DealiFont.b1Bold.systemFont
        case .medium(let style):
            switch style {
            case .text:
                return DealiFont.b2Regular.systemFont
            default:
                return DealiFont.b2Bold.systemFont
            }
        case .small(let style):
            switch style {
            case .text:
                return DealiFont.b4Regular.systemFont
            default:
                return DealiFont.b4Medium.systemFont
            }
        default:
            return DealiFont.b4Medium.systemFont
        }
    }
    
    var padding: DealiButtonPadding {
        switch self {
        case .large(let style):
            switch style {
            case .filled, .outlined, .tonal:
                return DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
            case .text:
                return DealiButtonPadding(horizontal: 16.0, vertical: 15.0)
            default:
                return DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
            }
        case .medium(_):
            return DealiButtonPadding(horizontal: 20.0, vertical: 13.0)
        case .small(_):
            return DealiButtonPadding(horizontal: 20.0, vertical: 13.0)

        default:
            return DealiButtonPadding()
        }
    }
    
    struct DealiButtonPadding {
        var horizontal: CGFloat = 0.0
        var vertical: CGFloat = 0.0
        var internalSpacing: CGFloat = 0.0
        
    }
}