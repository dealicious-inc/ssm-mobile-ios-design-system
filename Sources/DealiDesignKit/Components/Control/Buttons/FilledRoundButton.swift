//
//  FilledRoundButton.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 11/29/24.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledRoundLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundLarge02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.primary02)
    }

    // MARK: - Medium
    public static func btnFilledRoundMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.primary02)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledRoundSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundSemiMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.primary02)
    }
    
    // MARK: - Small
    public static func btnFilledRoundSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.primary02)
    }
}

// MARK: -  테스트 ButtonFilledRoundColor
public enum ButtonFilledRoundColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case gradient
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary01, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .b40, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .b20, text: .w50))
        case .gradient:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(gradient: PrimaryGradient.gradient, background: .clear, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        }
    }
}

// MARK: - ButtonFilledRoundConfig
public enum ButtonFilledRoundConfig: ClickableUnitButtonConfig {
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
        return .round
    }
}
