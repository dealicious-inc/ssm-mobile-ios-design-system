//
//  FilledSquareChips.swift
//  
//
//  Created by 박경우 on 2023/09/22.
//

import UIKit

class FilledSquareChips: NSObject {

}

final public class chipsFilledSquareLargePrimary01: SystemButton {
    public init() {
        super.init(color: ChipsFilledSquareColor.primary01, size: ChipsFilledSquareSize.large)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class chipsFilledSquareLargePrimary02: SystemButton {
    public init() {
        super.init(color: ChipsFilledSquareColor.primary02, size: ChipsFilledSquareSize.large)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class chipsFilledSquareLargeScondary01: SystemButton {
    public init() {
        super.init(color: ChipsFilledSquareColor.scondary01, size: ChipsFilledSquareSize.large)
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum ChipsFilledSquareColor: ButtonColorConfig {
    case primary01
    case primary02
    case scondary01
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary03,
                disabledBackgroundColor:  DealiColor.g10,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary03,
                disabledBackgroundColor:  DealiColor.g10,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50
            )
        case .scondary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.g10,
                disabledBackgroundColor:  DealiColor.g100,
                defaultTextColor: DealiColor.g10,
                disabledTextColor: DealiColor.g50
            )
        }
    }
}

public enum ChipsFilledSquareSize: ButtonSizeConfig {
    case large
    
    public var attribute: ButtonSize {
        switch self {
        case .large:
            return ButtonSize(
                font: UIFont.b2sb14,
                padding: DealiButtonPadding(horizontal: 12.0, vertical: 10.0)
            )
        }
        
    }
}
