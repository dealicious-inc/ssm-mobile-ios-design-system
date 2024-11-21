//
//  FilledSquareChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipFilledSquareLarge01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareLarge01")
    public static func chipsFilledSquareLarge01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary01)
    }
  
    public static func chipFilledSquareLarge02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary02)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareLarge02")
    public static func chipsFilledSquareLarge02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.primary02)
    }
    
    public static func chipFilledSquareLarge03() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.scondary01)
    }

    @available(*, deprecated, renamed: "chipFilledSquareLarge03")
    public static func chipsFilledSquareLarge03() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.large,
                                      color: ChipsFilledSquareColor.scondary01)
    }
    
    public static func chipFilledSquareMedium01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareMedium01")
    public static func chipsFilledSquareMedium01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.primary01)
    }
   
    public static func chipFilledSquareMedium02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.scondary01)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareMedium02")
    public static func chipsFilledSquareMedium02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.medium,
                                      color: ChipsFilledSquareColor.scondary01)
    }
   
    public static func chipFilledSquareSmall01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.small,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareSmall01")
    public static func chipsFilledSquareSmall01() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.small,
                                      color: ChipsFilledSquareColor.primary01)
    }
    
    public static func chipFilledSquareSmall02() -> ClickableComponentChip {
        return ClickableComponentChip(config: ChipsFilledSquareConfig.small,
                                      color: ChipsFilledSquareColor.scondary01)
    }
    
    @available(*, deprecated, renamed: "chipFilledSquareSmall02")
    public static func chipsFilledSquareSmall02() -> ClickableComponentChip {
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
            return ClickableColor(normal: ClickableColorSet(background: .primary03, text: .primary01),
                                  selected: ClickableColorSet(background: .primary03, text: .primary01, border: .primary01),
                                  disabled: ClickableColorSet(background: .g10, text: .g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .g10, text: .g100),
                                  selected: ClickableColorSet(background: .secondary03, text: .secondary02),
                                  disabled: ClickableColorSet(background: .g10, text: .g50))
        case .scondary01:
            return ClickableColor(normal: ClickableColorSet(background: .g10, text: .g100),
                                  selected: ClickableColorSet(background: .g20, text: .g100),
                                  disabled: ClickableColorSet(background: .g10, text: .g50))
        }
    }
}

public enum ChipsFilledSquareConfig: ClickableConfig {
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
        return .fixed(4.0)
    }
    
    public var padding: ClickableComponent.Configuration.Padding {
        return .square
    }
}
