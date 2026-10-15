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

    public static func btnFilledRoundLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.mbs01)
    }

    public static func btnFilledRoundLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.mbsGradient)
    }

    public static func btnFilledRoundLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.primary05)
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

    public static func btnFilledRoundMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.mbs01)
    }

    public static func btnFilledRoundMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.mbsGradient)
    }

    public static func btnFilledRoundMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.primary05)
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

    public static func btnFilledRoundSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.mbs01)
    }

    public static func btnFilledRoundSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.mbsGradient)
    }

    public static func btnFilledRoundSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.primary05)
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

    public static func btnFilledRoundSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.mbs01)
    }

    public static func btnFilledRoundSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.mbsGradient)
    }

    public static func btnFilledRoundSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.primary05)
    }
}

// MARK: - ButtonFilledRoundColor
/// btnFilled 와 같은 색 묶음이다. 01 primary01 / 02 primary gradient / 03 primary02 / 04 mbs01 / 05 mbs gradient / 06 primary05
public enum ButtonFilledRoundColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case primary05
    case mbs01
    case gradient
    case mbsGradient

    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary01, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .b40, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .b20, text: .w50))
        case .primary05:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary05, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .mbs01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .mbs01, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .gradient:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(gradient: PrimaryGradient.gradient, background: .clear, text: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .mbsGradient:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(gradient: MbsGradient.gradient01, background: .clear, text: .primary04),
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
