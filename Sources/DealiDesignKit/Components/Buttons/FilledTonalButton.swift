//
//  FilledTonalButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public enum FilledTonalColor: ButtonColorConfig {
    case primary01
    case primary02
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary03,
                disabledBackgroundColor:  DealiColor.g20,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.w20,
                disabledBackgroundColor: DealiColor.w20,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50
            )
        }
    }
}

public enum FilledTonalSize: ButtonSizeConfig {
    case large
    case medium
    case small
    
    public var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b1sb15,
                padding: DealiButtonPadding(horizontal: 40.0, vertical: 15.0)
            )
        case .medium:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 20.0, vertical: 13.0)
            )
        case .small:
            return ButtonSize(
                font: UIFont.b4sb12,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 13.0)
            )
        }
        
    }
}
