//
//  Chip.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipOutlineSquareLarge01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.large,
                                      color: ChipsSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineSquareLarge01")
    public static func chipsSquareLarge01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.large,
                                      color: ChipsSquareColor.primary01)
    }
    
    public static func chipOutlineSquareMedium01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.medium,
                                      color: ChipsSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineSquareMedium01")
    public static func chipsSquareBoldMedium01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.medium,
                                      color: ChipsSquareColor.primary01)
    }
    
    public static func chipOutlineSquareSmall01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.small,
                                      color: ChipsSquareColor.primary01)
    }
    
    @available(*, deprecated, renamed: "chipOutlineSquareSmall01")
    public static func chipsSquareSmall01() -> ChipComponent {
        return ChipComponent(config: ChipsSquareConfig.small,
                                      color: ChipsSquareColor.primary01)
    }
   
}

public enum ChipsSquareColor: ClickableColorConfig {
    case primary01
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .primary04, text: .g100, border: .g20),
                                  selected: ClickableColorSet(background: .primary04, text: .g100, border: .g100),
                                  disabled: ClickableColorSet(background: .primary04, text: .g50, border: .g20))
        }
    }
}

public enum ChipsSquareConfig: ClickableConfig {
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
    
    public var height: ButtonComponent.Configuration.Height {
        switch self {
        case .large:
            return .large
        case .medium:
            return .medium
        case .small:
            return .small
        }
    }
    
    public var cornerRadius: ButtonComponent.Configuration.Corner {
        return .fixed(4.0)
    }
    
    public var padding: ButtonComponent.Configuration.Padding {
        return .square
    }
}
