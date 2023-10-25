//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

extension DealiControl {
    public static func btnTextLargePrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargePrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargeSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.secondary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargeSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.secondary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargeSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.secondary03,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargeSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.secondary04,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextLargeSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b1sb15,
                                        size: ButtonTextSize.large,
                                        color: ButtonTextColor.secondary05,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.primary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.primary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.secondary01,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.secondary02,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.secondary03,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.secondary04,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextMediumSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b2r14,
                                        size: ButtonTextSize.medium,
                                        color: ButtonTextColor.secondary05,
                                        cornerRadius: .fixed(6.0))
    }
    
    public static func btnTextSmallPrimary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.primary01,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallPrimary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.primary02,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallSecondary01() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.secondary01,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallSecondary02() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.secondary02,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallSecondary03() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.secondary03,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallSecondary04() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.secondary04,
                                        cornerRadius: .fixed(4.0))
    }
    
    public static func btnTextSmallSecondary05() -> ClickableComponentButton {
        return ClickableComponentButton(font: .b3r13,
                                        size: ButtonTextSize.small,
                                        color: ButtonTextColor.secondary05,
                                        cornerRadius: .fixed(4.0))
    }
    
}

public enum ButtonTextColor: ClickableColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    case secondary05
    
    public var attribute: ClickableColor {
        switch self {
        case .primary01:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.primary01),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .primary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.primary04),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.w50))
        case .secondary01:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.secondary01),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary02:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g100),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary03:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g80),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary04:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g70),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        case .secondary05:
            return ClickableColor(normal: ClickableColorSet(background: .clear, text: DealiColor.g60),
                                  disabled: ClickableColorSet(background: .clear, text: DealiColor.g50))
        }
    }
}

public enum ButtonTextSize: ClickableSizeConfig {
    case large
    case medium
    case small
    
    public var attribute: ClickableSize {
        switch self {
        case .large:
            return ClickableSize(height: .large,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0)))
        case .medium:
            return ClickableSize(height: .medium,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0)))
        case .small:
            return ClickableSize(height: .medium,
                                 padding: ClickablePadding(left: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0),
                                                           right: ClickablePaddingSet(normal: 16.0, withImage: 16.0, internalSpacing: 4.0)))
        }
        
    }
}
