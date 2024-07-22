//
//  DealiControl.swift
//
//
//  Created by JohyeonYoon on 7/22/24.
//

import UIKit

extension DealiControl {
    
    // MARK: Small
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall01")
    public static func btnRoundFilledTonalSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary01
        )
    }
    
    public static func btnFilledTonalRoundSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary01
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall02")
    public static func btnRoundFilledTonalSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary02
        )
    }
    
    public static func btnFilledTonalRoundSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary02
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall03")
    public static func btnRoundFilledTonalSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary01
        )
    }
    
    public static func btnFilledTonalRoundSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary01
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall04")
    public static func btnRoundFilledTonalSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary02
        )
    }
    
    public static func btnFilledTonalRoundSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary02
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall05")
    public static func btnRoundFilledTonalSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary03
        )
    }
    
    public static func btnFilledTonalRoundSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary03
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall06")
    public static func btnRoundFilledTonalSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary04
        )
    }
    
    public static func btnFilledTonalRoundSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary04
        )
    }
    
}

// MARK: - ClickableColorConfig
public enum ButtonFilledTonalRoundColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
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
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50))
        }
    }
}

// MARK: - ClickableConfig
public enum ButtonFilledTonalRoundConfig: ClickableConfig {
    case small
    
    public var font: ClickableFont {
        switch self {
        case .small:
            return ClickableFont.button(font: .b3sb13)
        }
    }
    
    public var height: ClickableComponent.Configuration.Height {
        switch self {
        case .small:
            return .small
        }
    }
    
    public var cornerRadius: ClickableComponent.Configuration.Corner {
        return .capsule
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .round
    }
}
