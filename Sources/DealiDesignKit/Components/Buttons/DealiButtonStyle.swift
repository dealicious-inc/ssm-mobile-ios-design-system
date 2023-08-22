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

public enum DealiButtonSizeType: Equatable {
    case large
    case medium
    case small
}

public enum DealiButtonStyleType: Equatable {
    case filled
    case outlined
    case tonal
    case text
}

public enum DealiButtonColorType: Equatable {
    case `default`
}

struct DealiButtonStyle {
    
    var size: DealiButtonSizeType = .large {
        didSet {
            self.appearanceConfig = DealiButtonAppearanceConfig.appearanceConfigPreset(size: self.size, style: self.style)
        }
    }
    
    var style: DealiButtonStyleType = .filled {
        didSet {
            self.appearanceConfig = DealiButtonAppearanceConfig.appearanceConfigPreset(size: self.size, style: self.style)
            self.colorPreset = DealiButtonColorPreset.colorPreset(style: self.style, color: self.color)
        }
    }
    
    var color: DealiButtonColorType = .default {
        didSet {
            self.colorPreset = DealiButtonColorPreset.colorPreset(style: self.style, color: self.color)
        }
    }
    
    var appearanceConfig: DealiButtonAppearanceConfig = DealiButtonAppearanceConfig()
    var colorPreset: DealiButtonColorPreset = DealiButtonColorPreset()
}

/**
 설명: 버튼을 그릴때 지정되는 컬러를 제외한 속성 구조체
 */
struct DealiButtonAppearanceConfig {
    var horizontalPadding: CGFloat = 0.0
    var verticalPadding: CGFloat = 0.0
    var internalSpacing: CGFloat = 4.0
    var cornerRadius: CGFloat = 6.0
    var borderWidth: CGFloat = 1.0
    var hasBorder: Bool = false
    var font: UIFont = .b4sb12
    
    static func appearanceConfigPreset(size: DealiButtonSizeType, style: DealiButtonStyleType) -> DealiButtonAppearanceConfig {
        var preset = DealiButtonAppearanceConfig()
        
        switch size {
        case .large:
            preset.font = .b1sb15
            
            switch style {
            case .text:
                preset.horizontalPadding = 0.0
                preset.verticalPadding = 15.0
            default:
                preset.horizontalPadding = 40.0
                preset.verticalPadding = 15.0
            }
        case .medium:
            switch style {
            case .text:
                preset.font = .b2r14
            default:
                preset.font = .b2sb14
            }
            switch style {
            case .text:
                preset.horizontalPadding = 0.0
                preset.verticalPadding = 13.0
            default:
                preset.horizontalPadding = 20.0
                preset.verticalPadding = 13.0
            }
            
        case .small:
            switch style {
            case .text:
                preset.font = .b4r12
            default:
                preset.font = .b4sb12
            }
            
            switch style {
            case .filled:
                preset.horizontalPadding = 16.0
                preset.verticalPadding = 13.0
            case .text:
                preset.horizontalPadding = 0.0
                preset.verticalPadding = 13.0
            default:
                preset.horizontalPadding = 12.0
                preset.verticalPadding = 13.0
            }
        }
        
        preset.borderWidth = ((style == .filled || style == .text) ? 0.0 : 1.0)
        preset.hasBorder = (style == .outlined || style == .tonal)
        
        return preset
    }
}

/**
 설명: 버튼에 적용되는 color preset
 */
struct DealiButtonColorPreset {
    var defaultTitleColor: UIColor = .clear
    var disabledTitleColor: UIColor = .clear
    var pressedTitleColor: UIColor = .clear
    
    var defaultBackgroundColor: UIColor = .clear
    var disabledBackgroundColor: UIColor = .clear
    var pressedBackgroundColor: UIColor = .clear
    
    var defaultBorderColor: CGColor = UIColor.clear.cgColor
    var disabledBorderColor: CGColor = UIColor.clear.cgColor
    var pressedBorderColor: CGColor = UIColor.clear.cgColor
    
    static func colorPreset(style: DealiButtonStyleType, color: DealiButtonColorType) -> DealiButtonColorPreset {
        
        var preset = DealiButtonColorPreset()
        
        switch color {
        case .default:
            switch style {
            case .filled:
                preset.defaultTitleColor = DealiColor.primary04
                preset.disabledTitleColor = DealiColor.primary04
                preset.pressedTitleColor = DealiColor.primary04
                
                preset.defaultBackgroundColor = DealiColor.primary01
                preset.disabledBackgroundColor = DealiColor.bg04
                preset.pressedBackgroundColor = DealiColor.primary02
            case .outlined:
                preset.defaultTitleColor = DealiColor.primary01
                preset.disabledTitleColor = DealiColor.text05
                preset.pressedTitleColor = DealiColor.primary01
                
                preset.defaultBackgroundColor = DealiColor.primary04
                preset.disabledBackgroundColor = DealiColor.primary04
                preset.pressedBackgroundColor = DealiColor.primary04
                
                preset.defaultBorderColor = DealiColor.primary01.cgColor
                preset.disabledBorderColor = DealiColor.line03.cgColor
                preset.pressedBorderColor = DealiColor.primary02.cgColor
            case .tonal:
                preset.defaultTitleColor = DealiColor.text02
                preset.disabledTitleColor = DealiColor.text05
                preset.pressedTitleColor = DealiColor.text01
                
                preset.defaultBackgroundColor = DealiColor.bg07
                preset.disabledBackgroundColor = DealiColor.bg07
                preset.pressedBackgroundColor = DealiColor.bg07
                
                preset.defaultBorderColor = DealiColor.line03.cgColor
                preset.disabledBorderColor = DealiColor.line03.cgColor
                preset.pressedBorderColor = DealiColor.line03.cgColor
            case .text:
                preset.defaultTitleColor = DealiColor.text02
                preset.disabledTitleColor = DealiColor.text05
                preset.pressedTitleColor = DealiColor.text01
            }
        }
        
        return preset
    }
}
