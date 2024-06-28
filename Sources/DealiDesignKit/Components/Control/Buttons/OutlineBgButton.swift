//
//  File.swift
//  
//
//  Created by Hoji on 5/7/24.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnOutlineBgLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.large,
                                        color: ButtonBgOutlineColor.primary01)
    }

    public static func btnOutlineBgLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.large,
                                        color: ButtonBgOutlineColor.secondary01)
    }
    
    public static func btnOutlineBgLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.large,
                                        color: ButtonBgOutlineColor.secondary02)
    }
    
    public static func btnOutlineBgLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.large,
                                        color: ButtonBgOutlineColor.secondary03)
    }
    
    public static func btnOutlineBgLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.large,
                                        color: ButtonBgOutlineColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineBgMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.medium,
                                        color: ButtonBgOutlineColor.primary01)
    }

    public static func btnOutlineBgMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.medium,
                                        color: ButtonBgOutlineColor.secondary01)
    }
    
    public static func btnOutlineBgMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.medium,
                                        color: ButtonBgOutlineColor.secondary02)
    }
    
    public static func btnOutlineBgMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.medium,
                                        color: ButtonBgOutlineColor.secondary03)
    }
    
    public static func btnOutlineBgMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.medium,
                                        color: ButtonBgOutlineColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineBgSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.semiMedium,
                                        color: ButtonBgOutlineColor.primary01)
    }

    public static func btnOutlineBgSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.semiMedium,
                                        color: ButtonBgOutlineColor.secondary01)
    }
    
    public static func btnOutlineBgSemiMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.semiMedium,
                                        color: ButtonBgOutlineColor.secondary02)
    }
    
    public static func btnOutlineBgSemiMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.semiMedium,
                                        color: ButtonBgOutlineColor.secondary03)
    }
    
    public static func btnOutlineBgSemiMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.semiMedium,
                                        color: ButtonBgOutlineColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineBgSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.small,
                                        color: ButtonBgOutlineColor.primary01)
    }

    public static func btnOutlineBgSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.small,
                                        color: ButtonBgOutlineColor.secondary01)
    }
    
    public static func btnOutlineBgSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.small,
                                        color: ButtonBgOutlineColor.secondary02)
    }
    
    public static func btnOutlineBgSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.small,
                                        color: ButtonBgOutlineColor.secondary03)
    }
    
    public static func btnOutlineBgSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonBgOutlineConfig.small,
                                        color: ButtonBgOutlineColor.secondary04)
    }
}

public enum ButtonBgOutlineColor: ClickableColorConfig {
    case primary01
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.primary01, border: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.secondary01, border: DealiColor.secondary01),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g30),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g80, border: DealiColor.g30),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        }
    }
}

public enum ButtonBgOutlineConfig: ClickableConfig {
    case large
    case medium
    case semiMedium
    case small
    
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
        }
    }
}
