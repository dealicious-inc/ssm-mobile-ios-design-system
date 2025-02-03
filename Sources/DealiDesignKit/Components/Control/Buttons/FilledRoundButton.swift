//
//  FilledRoundButton.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 11/29/24.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledRoundLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundLarge02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.large,
                                        color: ButtonFilledRoundColor.primary02)
    }

    // MARK: - Medium
    public static func btnFilledRoundMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.medium,
                                        color: ButtonFilledRoundColor.primary02)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledRoundSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundSemiMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.semiMedium,
                                        color: ButtonFilledRoundColor.primary02)
    }
    
    // MARK: - Small
    public static func btnFilledRoundSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.primary01)
    }
    
    public static func btnFilledRoundSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.gradient)
    }
    
    public static func btnFilledRoundSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledRoundConfig.small,
                                        color: ButtonFilledRoundColor.primary02)
    }
}

// MARK: - ButtonFilledRoundColor
public enum ButtonFilledRoundColor: ClickableColorConfig {
    case primary01
    case primary02
    case gradient
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .primary01, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .b40, text: .primary04),
                                  disabled: ClickableColorSet(background: .b20, text: .w50))
        case .gradient:
            return ClickableColor(normal: ClickableColorSet(gradient: PrimaryGradient.gradient, background: .clear, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        }
    }
}

// MARK: - ButtonFilledRoundConfig
public enum ButtonFilledRoundConfig: ClickableConfig {
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
        return .capsule
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .square
    }
}
