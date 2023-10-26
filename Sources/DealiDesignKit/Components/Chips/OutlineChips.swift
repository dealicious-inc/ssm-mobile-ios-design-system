//
//  OutlineChips.swift
//  
//
//  Created by 박경우 on 2023/09/25.
//

import UIKit

extension DealiControl {
    public static func chipsOutlineLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsOutlineConfig.large,
                                      color: ChipsOutlineColor.primary01)
    }
    
    public static func chipsOutlineMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsOutlineConfig.medium,
                                      color: ChipsOutlineColor.primary01)
    }
    
    public static func chipsOutlineSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(settings: ChipsOutlineConfig.small,
                                      color: ChipsOutlineColor.primary01)
    }
}

public enum ChipsOutlineColor: ClickableColorConfig {
    case primary01
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g20),
                                  selected: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g100, border: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.primary04, text: DealiColor.g50, border: DealiColor.g20))
        }
    }
}


public enum ChipsOutlineConfig: ClickableConfig {
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

