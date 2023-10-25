//
//  FilledTonalButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnFilledTonalLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledTonalSize.large,
                                        color: ButtonFilledTonalColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledTonalSize.large,
                                        color: ButtonFilledTonalColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalLargeSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledTonalSize.large,
                                        color: ButtonFilledTonalColor.secondary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalLargeSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledTonalSize.large,
                                        color: ButtonFilledTonalColor.secondary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalLargeSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonFilledTonalSize.large,
                                        color: ButtonFilledTonalColor.secondary03,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledTonalSize.medium,
                                        color: ButtonFilledTonalColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledTonalSize.medium,
                                        color: ButtonFilledTonalColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalMediumSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledTonalSize.medium,
                                        color: ButtonFilledTonalColor.secondary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalMediumSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledTonalSize.medium,
                                        color: ButtonFilledTonalColor.secondary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalMediumSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2sb14,
                                        size: ButtonFilledTonalSize.medium,
                                        color: ButtonFilledTonalColor.secondary03,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnFilledTonalSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.small,
                                        color: ButtonFilledTonalColor.primary01,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnFilledTonalSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.small,
                                        color: ButtonFilledTonalColor.primary02,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnFilledTonalSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.small,
                                        color: ButtonFilledTonalColor.secondary01,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnFilledTonalSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.small,
                                        color: ButtonFilledTonalColor.secondary02,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnFilledTonalSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.small,
                                        color: ButtonFilledTonalColor.secondary03,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnRoundFilledTonalSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.roundSmall,
                                        color: ButtonFilledTonalColor.primary01,
                                        cornerRadius: .capsule)
    }
    
    public static func btnRoundFilledTonalSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.roundSmall,
                                        color: ButtonFilledTonalColor.primary02,
                                        cornerRadius: .capsule)
    }
    
    public static func btnRoundFilledTonalSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.roundSmall,
                                        color: ButtonFilledTonalColor.secondary01,
                                        cornerRadius: .capsule)
    }
    
    public static func btnRoundFilledTonalSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.roundSmall,
                                        color: ButtonFilledTonalColor.secondary02,
                                        cornerRadius: .capsule)
    }
    
    public static func btnRoundFilledTonalSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3sb13,
                                        size: ButtonFilledTonalSize.roundSmall,
                                        color: ButtonFilledTonalColor.secondary03,
                                        cornerRadius: .capsule)
    }
    
}

public enum ButtonFilledTonalColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.primary03, text: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.w20, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: DealiColor.w20, text: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g80),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g70),
                                  disabled: ClickableColorSet(background: DealiColor.g10, text: DealiColor.g50))
        }
    }
}

public enum ButtonFilledTonalSize: ClickableSizeConfig {
    case large
    case medium
    case small
    case roundSmall
    
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
        case .roundSmall:
            return ClickableSize(height: .small,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 12.0, internalSpacing: 4.0)))
        }
        
    }
}
