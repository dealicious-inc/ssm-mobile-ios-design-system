//
//  File.swift
//  
//
//  Created by Hoji on 5/7/24.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnOutlineBgLarge01() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgLarge03() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgLarge04() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgLarge05() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgLarge06() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineBgMedium01() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgMedium03() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgMedium04() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgMedium05() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgMedium06() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineBgSemiMedium01() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSemiMedium03() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSemiMedium04() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSemiMedium05() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSemiMedium06() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineBgSmall01() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSmall03() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSmall04() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSmall05() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSmall06() -> ButtonComponent {
        return ButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary04)
    }
}
// MARK: - ClickableColorConfig
public enum ButtonOutlineBgColor: ClickableColorConfig {
    case primary01
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .primary01, border: .primary01),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .secondary01, border: .secondary01),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .g100, border: .g100),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .g100, border: .g30),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g20))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .g80, border: .g30),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g20))
        }
    }
}
