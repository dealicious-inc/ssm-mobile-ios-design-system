//
//  FilledChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

final public class chipsFilledLargePrimary01: SystemButton {
    
    public init() {
        super.init(color: ChipsFilledColor.primary01, size: ChipsFilledSize.large)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum ChipsFilledColor: ButtonColorConfig {
    case primary01
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary03,
                disabledBackgroundColor:  DealiColor.g10,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50
            )
        }
    }
}

public enum ChipsFilledSize: ButtonSizeConfig {
    case large
    
    public var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 10.0)
            )
        }
        
    }
}
