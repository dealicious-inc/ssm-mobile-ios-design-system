//
//  OutlineButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnOutlineLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineLarge02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary01)
    }
   
    public static func btnOutlineLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineSemiMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineSemiMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineSemiMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineSemiMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: RoundOutline
    public static func btnRoundOutlineSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnRoundOutlineSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnRoundOutlineSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnRoundOutlineSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnRoundOutlineSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnRoundOutlineSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary04)
    }
}

// MARK: - ClickableColorConfig
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
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .primary01, border: .primary01),
                                  disabled: ClickableColorSet(background: .clear, text: .g50, border: .g30))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .primary04, border: .primary04),
                                  disabled: ClickableColorSet(background: .clear, text: .w50, border: .w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .secondary01, border: .secondary01),
                                  disabled: ClickableColorSet(background: .clear, text: .g50, border: .g30))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .g100, border: .g100),
                                  disabled: ClickableColorSet(background: .clear, text: .g50, border: .g30))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .g100, border: .g30),
                                  disabled: ClickableColorSet(background: .clear, text: .g50, border: .g20))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: .g80, border: .g30),
                                  disabled: ClickableColorSet(background: .clear, text: .g50, border: .g20))
        }
    }
}

// MARK: - ClickableConfig
public enum ButtonOutlineConfig: ClickableConfig {
    case large
    case medium
    case semiMedium
    case small
    case roundSmall
    
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
        case .semiMedium:
            return .semiMedium
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
        case .semiMedium:
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
        case .semiMedium:
            return .square
        case .small:
            return .square
        case .roundSmall:
            return .round
        }
    }
}
