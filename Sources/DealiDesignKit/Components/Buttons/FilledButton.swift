//
//  FilledButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public class btnFilledLargePrimary01: SystemButton {
    public init() {
        super.init(color: FilledColor.primary01, size: FilledSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledLargePrimary02: SystemButton {
    public init() {
        super.init(color: FilledColor.primary02, size: FilledSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledMediumPrimary01: SystemButton {
    public init() {
        super.init(color: FilledColor.primary01, size: FilledSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledMediumPrimary02: SystemButton {
    public init() {
        super.init(color: FilledColor.primary02, size: FilledSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledSmallPrimary01: SystemButton {
    public init() {
        super.init(color: FilledColor.primary01, size: FilledSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledSmallPrimary02: SystemButton {
    public init() {
        super.init(color: FilledColor.primary02, size: FilledSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum FilledColor: ButtonColorConfig {
    case primary01
    case primary02
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.primary01,
                disabledBackgroundColor:  DealiColor.g40,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.primary04
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.b40,
                disabledBackgroundColor: DealiColor.b20,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50
            )
        }
    }
}

public enum FilledSize: ButtonSizeConfig {
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
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 7.0)
            )
        }
        
    }
}
