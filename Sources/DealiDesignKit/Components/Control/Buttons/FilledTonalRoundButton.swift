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
    public static func btnRoundFilledTonalSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary01
        )
    }
    
    public static func btnFilledTonalRoundSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary01
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall02")
    public static func btnRoundFilledTonalSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary02
        )
    }
    
    public static func btnFilledTonalRoundSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.primary02
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall03")
    public static func btnRoundFilledTonalSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary01
        )
    }
    
    public static func btnFilledTonalRoundSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary01
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall04")
    public static func btnRoundFilledTonalSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary02
        )
    }
    
    public static func btnFilledTonalRoundSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary02
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall05")
    public static func btnRoundFilledTonalSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary03
        )
    }
    
    public static func btnFilledTonalRoundSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary03
        )
    }
    
    @available(*, deprecated, renamed: "btnFilledTonalRoundSmall06")
    public static func btnRoundFilledTonalSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary04
        )
    }
    
    public static func btnFilledTonalRoundSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(
            config: ButtonFilledTonalRoundConfig.small,
            color: ButtonFilledTonalRoundColor.secondary04
        )
    }
    
}

// MARK: - ClickableColorConfig
public enum ButtonFilledTonalRoundColor: ClickableUnitButtonColorConfig {
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

public enum ButtonFilledTonalRoundConfig: ClickableUnitButtonConfig {
    case small
    
    public var font: ClickableUnitButtonFont {
        switch self {
        case .small:
            return ClickableUnitButtonFont.set(font: .b3sb13)
        }
    }
    
    public var buttonType: ClickableUnitButton.ButtonPreset.ButtonType {
        switch self {
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
