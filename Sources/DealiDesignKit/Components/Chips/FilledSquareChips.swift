//
//  FilledSquareChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsFilledSquareLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.large,
                                      color: ChipsFilledSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareLargePrimary02() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.large,
                                      color: ChipsFilledSquareColor.primary02,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareLargeScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.large,
                                      color: ChipsFilledSquareColor.scondary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.medium,
                                      color: ChipsFilledSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareMediumScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.medium,
                                      color: ChipsFilledSquareColor.scondary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.small,
                                      color: ChipsFilledSquareColor.primary01,
                                      cornerRadius: .fixed(4.0))
    }
    
    public static func chipsFilledSquareSmallScondary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsSquareSize.small,
                                      color: ChipsFilledSquareColor.scondary01,
                                      cornerRadius: .fixed(4.0))
    }
}

public enum ChipsFilledSquareColor: ClickableColorConfig {
    case primary01
    case primary02
    case scondary01
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01, border: .clear),
                                  selected: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01, border: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50, border: .clear))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.secondary03, text: DealiColor.secondary01, border: .clear),
                                  selected: ClickableColorSet(background: DealiColor.secondary03, text: DealiColor.secondary02, border: .clear),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50, border: .clear))
        case .scondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g100, border: .clear),
                                  selected: ClickableColorSet(background: DealiColor.g20, text: DealiColor.g100, border: .clear),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50, border: .clear))
        }
    }
}

public enum ChipsFilledSquareSize: ClickableSizeConfig {
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
