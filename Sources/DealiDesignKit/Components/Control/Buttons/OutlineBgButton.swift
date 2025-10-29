//
//  File.swift
//  
//
//  Created by Hoji on 5/7/24.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnOutlineBgLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineBgMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineBgSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineBgColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineBgSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.primary01)
    }

    public static func btnOutlineBgSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary01)
    }
    
    public static func btnOutlineBgSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary02)
    }
    
    public static func btnOutlineBgSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary03)
    }
    
    public static func btnOutlineBgSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineBgColor.secondary04)
    }
}
// MARK: - ClickableColorConfig
public enum ButtonOutlineBgColor: ClickableUnitButtonColorConfig {
    case primary01
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .primary01, border: .primary01),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .secondary01, border: .secondary01),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .g100, border: .g100),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50, border: .g30))
        case .secondary03:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .g100, border: .g30),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50, border: .g20))
        case .secondary04:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .g80, border: .g30),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50, border: .g20))
        }
    }
}
