//
//  FilledTonalButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledTonalLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalLarge02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnFilledTonalMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary02)
    }
   
    public static func btnFilledTonalMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
    // MARK: Small
    // MARK: - Semi Medium
    public static func btnFilledTonalSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalSemiMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary02)
    }
   
    public static func btnFilledTonalSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.semiMedium,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnFilledTonalSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary04)
    }
    
}

// MARK: - ClickableColorConfig
public enum ButtonFilledTonalColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary03, text: .primary01),
                                  disabled: ClickableUnitButtonColorSet(background: .g10, text: .g50))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .w20, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .w20, text: .w50))
        case .secondary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .g10, text: .g100),
                                  disabled: ClickableUnitButtonColorSet(background: .g10, text: .g50))
        case .secondary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .g10, text: .g80),
                                  disabled: ClickableUnitButtonColorSet(background: .g10, text: .g50))
        case .secondary03:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .g10, text: .g70),
                                  disabled: ClickableUnitButtonColorSet(background: .g10, text: .g50))
        case .secondary04:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary04, text: .g100),
                                  disabled: ClickableUnitButtonColorSet(background: .primary04, text: .g50))
        }
    }
}

// MARK: - ButtonFilledTonalConfig
public enum ButtonFilledTonalConfig: ClickableUnitButtonConfig {
    case large
    case medium
    case semiMedium
    case small
    
    public var font: ClickableUnitButtonFont {
        switch self {
        case .large:
            return ClickableUnitButtonFont.set(font: .b1sb15)
        case .medium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .semiMedium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .small:
            return ClickableUnitButtonFont.set(font: .b3sb13)
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
