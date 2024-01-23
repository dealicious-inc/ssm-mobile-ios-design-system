//
//  FilledChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsFilledLarge01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.large,
                                      color: ChipsFilledColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipsFilledLarge01")
    public static func chipsFilledLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.large,
                                      color: ChipsFilledColor.primary01)
    }
    
    public static func chipsFilledMedium01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.medium,
                                      color: ChipsFilledColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipsFilledMedium01")
    public static func chipsFilledMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.medium,
                                      color: ChipsFilledColor.primary01)
    }
    
    public static func chipsFilledSmall01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.small,
                                      color: ChipsFilledColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipsFilledSmall01")
    public static func chipsFilledSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledConfig.small,
                                      color: ChipsFilledColor.primary01)
    }
}

public enum ChipsFilledColor: ClickableColorConfig {
    case primary01
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01, border: .clear),
                                  selected: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01, border: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50, border: .clear))
        }
    }
}

public enum ChipsFilledConfig: ClickableConfig {
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
        return .raund
    }
}
