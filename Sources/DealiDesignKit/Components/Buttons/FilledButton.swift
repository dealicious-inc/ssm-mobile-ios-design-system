//
//  FilledButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnFilledLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledSize.large,
                                        color: ButtonFilledColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledLargeGradient() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledSize.large,
                                        color: ButtonFilledColor.gradient,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledSize.large,
                                        color: ButtonFilledColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledSize.medium,
                                        color: ButtonFilledColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledSize.medium,
                                        color: ButtonFilledColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledSize.small,
                                        color: ButtonFilledColor.primary01,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnFilledSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledSize.small,
                                        color: ButtonFilledColor.primary02,
                                        cornerRadius: .fixed(4.0))
    }
}

public enum ButtonFilledColor: ClickableColorConfig {
    case primary01
    case primary02
    case gradient
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary01, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.g40, text: DealiColor.primary04))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.b40, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.b20, text: DealiColor.w50))
        case .gradient:
            return ClickableColor(normal: ClickableColorSet(gradientBackground: DealiColor.primaryGradient, background: .clear, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.g40, text: DealiColor.primary04))
        }
    }
}

public enum ButtonFilledSize: ClickableSizeConfig {
    case large
    case medium
    case small
    
    public var attribute: ClickableSize {
        switch self {
        case .large:
            return ClickableSize(height: .large,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0)))
        case .medium:
            return ClickableSize(height: .medium,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 20.0, withImage: 16.0, internalSpacing: 4.0)))
        case .small:
            return ClickableSize(height: .small,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 12.0, withImage: 8.0, internalSpacing: 4.0)))
        }
        
    }
}
