//
//  TextButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public enum TextColor: ButtonColorConfig {
    case primary01
    case primary02
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor:  .clear,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.primary01.cgColor,
                disabledBorderColor: DealiColor.g30.cgColor
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50,
                defaultBorderColor: DealiColor.primary04.cgColor,
                disabledBorderColor: DealiColor.w50.cgColor
            )
        }
    }
}

public enum TextSize: ButtonSizeConfig {
    case large
    case medium
    case small
    
    public var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b1sb15,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 15.0)
            )
        case .medium:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 13.0)
            )
        case .small:
            return ButtonSize(
                font: UIFont.b1sb15,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 7.0)
            )
        }
        
    }
}
