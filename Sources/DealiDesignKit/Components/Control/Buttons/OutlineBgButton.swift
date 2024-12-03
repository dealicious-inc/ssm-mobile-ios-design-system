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
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineBgMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineBgSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSemiMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSemiMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSemiMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineBgSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
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
