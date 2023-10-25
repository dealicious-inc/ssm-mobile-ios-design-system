//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnTextLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextLargeSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextLargeSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextLargeSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextLargeSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextLargeSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.large,
                                        color: ButtonTextColor.secondary05)
    }
    
    public static func btnTextMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextMediumSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextMediumSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextMediumSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextMediumSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextMediumSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.medium,
                                        color: ButtonTextColor.secondary05)
    }
    
    public static func btnTextSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextSmallSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextSmallSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonTextSettings.small,
                                        color: ButtonTextColor.secondary05)
    }
    
}

public enum ButtonTextColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    case secondary05
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.secondary01),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g80),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g70),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary05:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g60),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        }
    }
}

public enum ButtonTextSettings: ClickableSettingsConfig {
    case large
    case medium
    case small
    
    public var font: UIFont {
        switch self {
        case .large:
            return .b1sb15
        case .medium:
            return .b2r14
        case .small:
            return .b3r13
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
        return .text
    }
}
