//
//  FilledSquareChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsFilledSquareLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    public static func chipsFilledSquareLargePrimary02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary02)
    }
    
    public static func chipsFilledSquareLargeScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.scondary01)
    }
    
    public static func chipsFilledSquareMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    public static func chipsFilledSquareMediumScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.scondary01)
    }
    
    public static func chipsFilledSquareSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.small,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    public static func chipsFilledSquareSmallScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.small,
                                      color: ChipsFilledSquareColor.scondary01)
    }
}

public enum ChipsFilledSquareColor: ClickableColorConfig {
    case primary01
    case primary02
    case scondary01
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01),
                                  selected: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01, border: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.secondary03, text: DealiColor.secondary01),
                                  selected: ClickableColorSet(background: DealiColor.secondary03, text: DealiColor.secondary02),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .scondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g100),
                                  selected: ClickableColorSet(background: DealiColor.g20, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        }
    }
}

public enum ChipsFilledSquareConfig: ClickableConfig {
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
        return .fixed(4.0)
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .square
    }
}
