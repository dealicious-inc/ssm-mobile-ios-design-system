//
//  OutlineButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnOutlineLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineLarge02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary01)
    }
   
    public static func btnOutlineLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.large,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Medium
    public static func btnOutlineMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.medium,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Semi Medium
    public static func btnOutlineSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineSemiMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.semiMedium,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: - Small
    public static func btnOutlineSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnOutlineSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnOutlineSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnOutlineSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnOutlineSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnOutlineSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.small,
                                        color: ButtonOutlineColor.secondary04)
    }
    
    // MARK: RoundOutline
    public static func btnRoundOutlineSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.primary01)
    }
    
    public static func btnRoundOutlineSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.primary02)
    }
    
    public static func btnRoundOutlineSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary01)
    }
    
    public static func btnRoundOutlineSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary02)
    }
    
    public static func btnRoundOutlineSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary03)
    }
    
    public static func btnRoundOutlineSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonOutlineConfig.roundSmall,
                                        color: ButtonOutlineColor.secondary04)
    }
}

// MARK: - ClickableColorConfig
public enum ButtonOutlineColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .primary01, border: .primary01),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50, border: .g30))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .primary04, border: .primary04),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .w50, border: .w50))
        case .secondary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .secondary01, border: .secondary01),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50, border: .g30))
        case .secondary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g100, border: .g100),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50, border: .g30))
        case .secondary03:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g100, border: .g30),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50, border: .g20))
        case .secondary04:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .clear, text: .g80, border: .g30),
                                  disabled: ClickableUnitButtonColorSet(background: .clear, text: .g50, border: .g20))
        }
    }
}

// MARK: - ClickableConfig
public enum ButtonOutlineConfig: ClickableUnitButtonConfig {
    case large
    case medium
    case semiMedium
    case small
    case roundSmall
    
    public var font: ClickableUnitButtonFont {
        switch self {
        case .large:
            return ClickableUnitButtonFont.set(font: .b1sb15)
        case .medium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .semiMedium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .small, .roundSmall:
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
        case .roundSmall:
            return .small
        }
    }
    
    public var buttonPadding: ClickableUnitButton.ButtonPreset.ButtonPadding {
        return .normal
    }
    
    public var cornerRadius: ClickableUnitButton.ButtonPreset.Corner {
        switch self {
        case .roundSmall:
            return .round
        default:
            return .normal
        }
        
    }
}
