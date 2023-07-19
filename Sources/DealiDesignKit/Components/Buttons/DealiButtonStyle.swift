//
//  DealiButtonStyle.swift
//
//
//  Created by 윤조현 on 2023/06/26.
//

import UIKit

/// 디자인시스템 Buttons 에 적용되는 스타일.
///
/// 크기(large, medium, small)과 모양(filled, outlined, tonal, text)를 곱한 경우의 수가 있다.
///
/// `DealiButtonStyle` 에 정의된 크기 속성에 associated type으로 모양(filled, outlined, tonal, text) 속성을 넣어서 사용한다.
///
/// ```swift
/// // 예시
/// let myButton = DealiButton()
/// myButton.style = .medium(style: .filled)
/// ```
///
/// 크기와 상관 없는 속성 편집할 경우 `baseStyle` 사용해 처리
/// ```swift
/// var defaultBackgroundColor: UIColor {
///      switch self.baseStyle {
///      case .filled:
///          return DealiColor.primary01
///      case .tonal:
///          return DealiColor.bg07
///      default:
///          return DealiColor.primary04
///      }
/// }
/// ```
public enum DealiButtonStyle: Equatable {
    indirect case large(style: DealiButtonStyle)
    indirect case medium(style: DealiButtonStyle)
    indirect case small(style: DealiButtonStyle)
    
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