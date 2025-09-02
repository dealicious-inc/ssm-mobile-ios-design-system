//
//  FilledButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    // MARK: Large
    public static func btnFilledLarge01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledLarge02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledLarge03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledLarge04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledLarge05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledLarge06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary05)
    }

    // MARK: - Medium
    public static func btnFilledMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary05)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledSemiMedium01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSemiMedium02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledSemiMedium03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledSemiMedium04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledSemiMedium05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledSemiMedium06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary05)
    }
    
    // MARK: - Small
    public static func btnFilledSmall01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSmall02() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledSmall03() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledSmall04() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledSmall05() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledSmall06() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary05)
    }
}

// MARK: - ButtonFilledColor
public enum ButtonFilledColor: ClickableUnitButtonColorConfig {
    case primary01
    case primary02
    case primary05
    case mbs01
    case primaryGradient
    case mbsGradient
    
    public var attribute: ClickableUnitButtonColor {
        switch self {
        case .primary01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary01, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .primary02:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .b40, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .b20, text: .w50))
        case .primary05:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .primary05, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
            
        case .mbs01:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(background: .mbs01, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .primaryGradient:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(gradient: PrimaryGradient.gradient, background: .clear, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
        case .mbsGradient:
            return ClickableUnitButtonColor(normal: ClickableUnitButtonColorSet(gradient: MbsGradient.gradient01, background: .clear, text: .primary04),
                                            disabled: ClickableUnitButtonColorSet(background: .g40, text: .primary04))
            
        }
    }
}

// MARK: - ButtonFilledConfig
public enum ButtonFilledConfig: ClickableUnitButtonConfig {
    case large
    case medium
    case semiMedium
    case small
    
    public var font: ClickableUnitButtonFont {
        switch self {
        case .large:
            return ClickableUnitButtonFont.set(font: .b1sb15)
        case .medium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .semiMedium:
            return ClickableUnitButtonFont.set(font: .b2sb14)
        case .small:
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
        }
    }
    
    public var buttonPadding: ClickableUnitButton.ButtonPreset.ButtonPadding {
        return .normal
    }
    
    public var cornerRadius: ClickableUnitButton.ButtonPreset.Corner {
        return .normal
    }
}
