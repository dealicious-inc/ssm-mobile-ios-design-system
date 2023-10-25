//
//  FilledButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnFilledLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.large,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledLargeGradient() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.large,
                                        color: ButtonFilledColor.gradient)
    }
    
    public static func btnFilledLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.large,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.medium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.medium,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.small,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonFilledSettings.small,
                                        color: ButtonFilledColor.primary02)
    }
}

public enum ButtonFilledColor: ClickableColorConfig {
    case primary01
    case primary02
    case gradient
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary01, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.g40, text: DealiColor.primary04))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.b40, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.b20, text: DealiColor.w50))
        case .gradient:
            return ClickableColor(normal: ClickableColorSet(gradientBackground: DealiColor.primaryGradient, background: .clear, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.g40, text: DealiColor.primary04))
        }
    }
}

public enum ButtonFilledSettings: ClickableSettingsConfig {
    case large
    case medium
    case small
    
    public var font: UIFont {
        switch self {
        case .large:
            return .b1sb15
        case .medium:
            return .b2sb14
        case .small:
            return .b3sb13
        }
    }
    
    public var height: ClickableComponent.Configuration.Height {
        switch self {
        case .large:
            return .large
        case .medium:
            return .medium
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
        case .small:
            return .fixed(4.0)
        }
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .square
    }
}
