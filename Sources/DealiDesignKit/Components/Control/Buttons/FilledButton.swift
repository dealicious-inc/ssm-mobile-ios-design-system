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
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.large,
                                        color: ButtonFilledColor.primary05)
    }

    // MARK: - Medium
    public static func btnFilledMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.medium,
                                        color: ButtonFilledColor.primary05)
    }
    
    // MARK: - Semi Medium
    public static func btnFilledSemiMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSemiMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledSemiMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledSemiMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledSemiMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledSemiMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.semiMedium,
                                        color: ButtonFilledColor.primary05)
    }
    
    // MARK: - Small
    public static func btnFilledSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary01)
    }
    
    public static func btnFilledSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primaryGradient)
    }
    
    public static func btnFilledSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary02)
    }
    
    public static func btnFilledSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.mbs01)
    }
    
    public static func btnFilledSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.mbsGradient)
    }
    
    public static func btnFilledSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonFilledConfig.small,
                                        color: ButtonFilledColor.primary05)
    }
    
    public static func btnFilledLargeTest01() -> ClickableUnitButtonComponent {
        return ClickableUnitButtonComponent(config: ButtonFilledConfigTest.large,
                                            color: ButtonFilledColorTest.primary01.attribute)
    }
}

// MARK: - ButtonFilledColor
public enum ButtonFilledColor: ClickableColorConfig {
    case primary01
    case primary02
    case primary05
    case mbs01
    case primaryGradient
    case mbsGradient
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .primary01, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .b40, text: .primary04),
                                  disabled: ClickableColorSet(background: .b20, text: .w50))
        case .primary05:
            return ClickableColor(normal: ClickableColorSet(background: .primary05, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
      
        case .mbs01:
            return ClickableColor(normal: ClickableColorSet(background: .mbs01, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        case .primaryGradient:
            return ClickableColor(normal: ClickableColorSet(gradient: PrimaryGradient.gradient, background: .clear, text: .primary04),
                                  disabled: ClickableColorSet(background: .g40, text: .primary04))
        case .mbsGradient:
            return ClickableColor(normal: ClickableColorSet(gradient: MbsGradient.gradient01, background: .clear, text: .primary04),
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

// MARK: -  테스트 ButtonFilledRoundColor
public enum ButtonFilledColorTest {
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

// MARK: - ButtonFilledRoundConfig
public enum ButtonFilledConfigTest: ClickableUnitButtonConfig {
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
    
//    public var cornerRadius: ClickableComponent.Configuration.Corner {
//        return .capsule
//    }
//
//    public var padding: ClickableComponent.Configuration.Padding {
//        return .square
//    }
}
