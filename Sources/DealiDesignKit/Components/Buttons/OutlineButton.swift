//
//  OutlineButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnOutlineLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineLargeSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineLargeSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineLargeSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineLargeSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.large,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    public static func btnOutlineMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineMediumSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineMediumSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineMediumSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineMediumSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.medium,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    public static func btnOutlineSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineSmallSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.small,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    public static func btnRoundOutlineSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnRoundOutlineSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnRoundOutlineSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnRoundOutlineSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnRoundOutlineSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnRoundOutlineSmallSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(settings: ButtonOutlineSettings.roundSmall,
                                        color: ButtonOutlineColor.secondary04)
    }

}

public enum ButtonOutlineColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.primary01, border: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.primary04, border: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.w50, border: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.secondary01, border: DealiColor.secondary01),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g30))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g30),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g80, border: DealiColor.g30),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        }
    }
}

public enum ButtonOutlineSettings: ClickableSettingsConfig {
    case large
    case medium
    case small
    case roundSmall
    
    public var font: UIFont {
        switch self {
        case .large:
            return .b1sb15
        case .medium:
            return .b2sb14
        case .small:
            return .b3sb13
        case .roundSmall:
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
        case .roundSmall:
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
        case .roundSmall:
            return .capsule
        }
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        switch self {
        case .large:
            return .square
        case .medium:
            return .square
        case .small:
            return .square
        case .roundSmall:
            return .raund
        }
    }
}
