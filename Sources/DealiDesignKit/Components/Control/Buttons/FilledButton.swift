//
//  FilledButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledLarge02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.gradient)
    }
    
    public static func btnFilledLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary02)
    }

    // MARK: - Medium
    public static func btnFilledMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.gradient)
    }
    
    public static func btnFilledMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary02)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSemiMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.gradient)
    }
    
    public static func btnFilledSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary02)
    }
    
    
    // MARK: - Small
    public static func btnFilledSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.gradient)
    }
    
    public static func btnFilledSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary02)
    }
}

// MARK: - ButtonFilledColor
public enum ButtonFilledColor: ClickableColorConfig {
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
            return ClickableColor(normal: ClickableColorSet(gradientBackground: UIColor.primaryGradient, background: .clear, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        }
    }
}

// MARK: - ButtonFilledConfig
public enum ButtonFilledConfig: ClickableConfig {
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
        return .square
    }
}
