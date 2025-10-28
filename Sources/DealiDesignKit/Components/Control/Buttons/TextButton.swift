//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnTextLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.primary01)
    }
  
    public static func btnTextLarge02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.primary02)
    }
   
    public static func btnTextLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary02)
    }
   
    public static func btnTextLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextLarge07() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary05)
    }
    
    // MARK: - Medium
    public static func btnTextMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextMedium07() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary05)
    }
    
    // MARK: - Semi Medium
    public static func btnTextSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextSemiMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextSemiMedium07() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.semiMedium,
                                        color: ButtonTextColor.secondary05)
    }
    
    // MARK: - Small
    public static func btnTextSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextSmall07() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary05)
    }
    
}
// MARK: - ClickableColorConfig
public enum ButtonTextColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    case secondary05
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .primary01),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .w50))
        case .secondary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .secondary01),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        case .secondary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g100),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        case .secondary03:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g80),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        case .secondary04:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g70),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        case .secondary05:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g60),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50))
        }
    }
}
// MARK: - ClickableConfig
public enum ButtonTextConfig: ClickableUnitButtonConfig {
    case large
    case medium
    case semiMedium
    case small
    
    public var font: ClickableUnitButtonFont {
        switch self {
        case .large:
            return ClickableUnitButtonFont.set(font: .b1sb15)
        case .medium:
            return ClickableUnitButtonFont.set(font: .b2r14)
        case .semiMedium:
            return ClickableUnitButtonFont.set(font: .b2r14)
        case .small:
            return ClickableUnitButtonFont.set(font: .b3r13)
        }
    }
    
    public var buttonType: ClickableUnitButton.ButtonPreset.ButtonType {
        switch self {
        case .large:
            return .large
        case .medium:
            return .medium
        case .semiMedium:
            return .semiMedium
        case .small:
            return .small
        }
    }
    
    public var buttonPadding: ClickableUnitButton.ButtonPreset.ButtonPadding {
        return .normal
    }
    
    public var cornerRadius: ClickableUnitButton.ButtonPreset.Corner {
        return .normal
    }
}
