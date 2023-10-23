//
//  FilledChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

extension DealiControl {
    public static func chipsFilledLargePrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsFilledSize.large,
                                      color: ChipsFilledColor.primary01,
                                      cornerRadius: .capsule)
    }
    
    public static func chipsFilledMediumPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsFilledSize.medium,
                                      color: ChipsFilledColor.primary01,
                                      cornerRadius: .capsule)
    }
    
    public static func chipsFilledSmallPrimary01() -> ClickableComponentChip {
        return ClickableComponentChip(font: .b2sb14,
                                      size: ChipsFilledSize.small,
                                      color: ChipsFilledColor.primary01,
                                      cornerRadius: .capsule)
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

public enum ChipsFilledSize: ClickableSizeConfig {
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
