//
//  OutlineChips.swift
//  
//
//  Created by 박경우 on 2023/09/25.
//

import UIKit

final public class chipsOutlineLargePrimary01: SystemButton {
    public init() {
        super.init(color: ChipsOutlineColor.primary01, size: ChipsOutlineSize.medium)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class chipsOutlineMediumPrimary01: SystemButton {
    public init() {
        super.init(color: ChipsOutlineColor.primary01, size: ChipsOutlineSize.medium)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum ChipsOutlineColor: ButtonColorConfig {
    case primary01
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary04,
                disabledBackgroundColor:  DealiColor.primary04,
                defaultTextColor: DealiColor.g100,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.g20,
                disabledBorderColor: DealiColor.g20
            )
        }
    }
}

public enum ChipsOutlineSize: ButtonSizeConfig {
    case large
    case medium
    
    public var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 10.0)
            )
        case .medium:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 10.0)
            )
        }
        
    }
}
