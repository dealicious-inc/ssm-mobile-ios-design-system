//
//  FilledTonalButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnFilledTonalLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalLargeSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalLargeSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalLargeSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.large,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalMediumSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalMediumSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalMediumSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.medium,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnFilledTonalSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnFilledTonalSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnFilledTonalSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnFilledTonalSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnFilledTonalSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.small,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
    public static func btnRoundFilledTonalSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.primary01)
    }
    
    public static func btnRoundFilledTonalSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.primary02)
    }
    
    public static func btnRoundFilledTonalSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary01)
    }
    
    public static func btnRoundFilledTonalSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary02)
    }
    
    public static func btnRoundFilledTonalSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledTonalConfig.roundSmall,
                                        color: ButtonFilledTonalColor.secondary03)
    }
    
}

public enum ButtonFilledTonalColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.w20, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.w20, text: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g80),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g70),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        }
    }
}

public enum ButtonFilledTonalConfig: ClickableConfig {
    case large
    case medium
    case small
    case roundSmall
    
    public var font: ClickableFont {
        switch self {
        case .large:
            return ClickableFont.button(font: .b1sb15)
        case .medium:
            return ClickableFont.button(font: .b2sb14)
        case .small:
            return ClickableFont.button(font: .b3sb13)
        case .roundSmall:
            return ClickableFont.button(font: .b3sb13)
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
