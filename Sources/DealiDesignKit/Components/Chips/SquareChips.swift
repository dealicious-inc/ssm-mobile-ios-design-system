//
//  Chip.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsSquareLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.large,
                                      color: ChipsSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsSquareMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.medium,
                                      color: ChipsSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsSquareSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.small,
                                      color: ChipsSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
}

public enum ChipsSquareColor: ClickableColorConfig {
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

public enum ChipsSquareSize: ClickableSizeConfig {
    case large
    case medium
    case small
    
    public var attribute: ClickableSize {
        switch self {
        case .large:
            return ClickableSize(height: .large,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0)))
        case .medium:
            return ClickableSize(height: .medium,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0)))
        case .small:
            return ClickableSize(height: .small,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0)))
        }
        
    }
}
