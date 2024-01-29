//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnTextLarge01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.primary01)
    }
  
    public static func btnTextLarge02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.primary02)
    }
   
    public static func btnTextLarge03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextLarge04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary02)
    }
   
    public static func btnTextLarge05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextLarge06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextLarge07() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.large,
                                        color: ButtonTextColor.secondary05)
    }
    
    public static func btnTextMedium01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextMedium02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextMedium03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextMedium04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextMedium05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextMedium06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextMedium07() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.medium,
                                        color: ButtonTextColor.secondary05)
    }
    
    public static func btnTextSmall01() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.primary01)
    }
    
    public static func btnTextSmall02() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.primary02)
    }
    
    public static func btnTextSmall03() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary01)
    }
    
    public static func btnTextSmall04() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary02)
    }
    
    public static func btnTextSmall05() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary03)
    }
    
    public static func btnTextSmall06() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
                                        color: ButtonTextColor.secondary04)
    }
    
    public static func btnTextSmall07() -> ClickableComponentButton {
        return ClickableComponentButton(config: ButtonTextConfig.small,
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

public enum ButtonTextConfig: ClickableConfig {
    case large
    case medium
    case small
    
    public var font: ClickableFont {
        switch self {
        case .large:
            return ClickableFont.button(font: .b1sb15)
        case .medium:
            return ClickableFont.button(font: .b2r14)
        case .small:
            return ClickableFont.button(font: .b3r13)
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
