//
//  FilledChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsFilledLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsFilledConfig.large,
                                      color: ChipsFilledColor.primary01)
    }
    
    public static func chipsFilledMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsFilledConfig.medium,
                                      color: ChipsFilledColor.primary01)
    }
    
    public static func chipsFilledSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsFilledConfig.small,
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
    
    public var font: UIFont {
        switch self {
        case .large:
            return .b2sb14
        case .medium:
            return .b2sb14
        case .small:
            return .b2sb14
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
