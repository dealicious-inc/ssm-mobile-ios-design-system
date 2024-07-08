//
//  FilledTonalButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledTonalLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalLarge02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnFilledTonalMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary02)
    }
   
    public static func btnFilledTonalMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledTonalSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalSemiMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalSemiMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary02)
    }
   
    public static func btnFilledTonalSemiMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalSemiMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnFilledTonalSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary03)
    }
   
    public static func btnRoundFilledTonalSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnRoundFilledTonalSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.primary02)
    }
   
    public static func btnRoundFilledTonalSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnRoundFilledTonalSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnRoundFilledTonalSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
}

// MARK: - ClickableColorConfig
public enum ButtonFilledTonalColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.w20, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.w20, text: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g80),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g70),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50))
        }
    }
}

// MARK: - ClickableConfig
public enum ButtonFilledTonalConfig: ClickableConfig {
    case large
    case medium
    case semiMedium
    case small
    case roundSmall
    
    public var font: ClickableFont {
        switch self {
        case .large:
            return ClickableFont.button(font: .b1sb15)
        case .medium:
            return ClickableFont.button(font: .b2sb14)
        case .semiMedium:
            return ClickableFont.button(font: .b2sb14)
        case .small:
            return ClickableFont.button(font: .b3sb13)
        case .roundSmall:
            return ClickableFont.button(font: .b3sb13)
        }
    }
    
    public var height: ClickableComponent.Configuration.Height {
        switch self {
        case .large:
            return .large
        case .medium:
            return .medium
        case .semiMedium:
            return .semiMedium
        case .small:
            return .small
        case .roundSmall:
            return .small
        }
    }
    
    public var cornerRadius: ClickableComponent.Configuration.Corner {
        switch self {
        case .large:
            return .fixed(6.0)
        case .medium:
            return .fixed(6.0)
        case .semiMedium:
            return .fixed(6.0)
        case .small:
            return .fixed(4.0)
        case .roundSmall:
            return .capsule
        }
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        switch self {
        case .large:
            return .square
        case .medium:
            return .square
        case .semiMedium:
            return .square
        case .small:
            return .square
        case .roundSmall:
            return .raund
        }
    }
}
