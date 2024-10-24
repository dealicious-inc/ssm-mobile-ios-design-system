//
//  OutlineChips.swift
//  
//
//  Created by 박경우 on 2023/09/25.
//

import UIKit

extension DealiControl {
    public static func chipOutlineLarge01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.large,
                                      color: ChipsOutlineColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineLarge01")
    public static func chipsOutlineLarge01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.large,
                                      color: ChipsOutlineColor.primary01)
    }
    
    public static func chipOutlineMedium01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.medium,
                                      color: ChipsOutlineColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineMedium01")
    public static func chipsOutlineMedium01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.medium,
                                      color: ChipsOutlineColor.primary01)
    }
    
    public static func chipOutlineMedium02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.medium,
                                      color: ChipsOutlineColor.primary02)
    }
    
    @available(*, deprecated, renamed: "chipOutlineMedium02")
    public static func chipsOutlineMedium02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.medium,
                                      color: ChipsOutlineColor.primary02)
    }
    
    public static func chipOutlineSmall01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.small,
                                      color: ChipsOutlineColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineSmall01")
    public static func chipsOutlineSmall01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsOutlineConfig.small,
                                      color: ChipsOutlineColor.primary01)
    }
}

public enum ChipsOutlineColor: ClickableColorConfig {
    case primary01
    case primary02
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g20),
                                  selected: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g80, border: DealiColor.g30),
                                  selected: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        }
    }
}


public enum ChipsOutlineConfig: ClickableConfig {
    case large
    case medium
    case small
    
    public var font: ClickableFont {
        switch self {
        case .large:
            return ClickableFont.chip(font: .b2sb14)
        case .medium:
            return ClickableFont.chip(font: .b2sb14)
        case .small:
            return ClickableFont(normal: .b2r14, selected: .b2sb14, disabled: .b2r14)
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
        return .capsule
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .round
    }
}

