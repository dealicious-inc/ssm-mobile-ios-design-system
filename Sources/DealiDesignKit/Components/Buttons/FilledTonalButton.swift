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
    case secondary01
    case secondary02
    case secondary03
    
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
        case .secondary01:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.g10,
                disabledBackgroundColor: DealiColor.g10,
                defaultTextColor: DealiColor.g100,
                disabledTextColor: DealiColor.g50
            )
        case .secondary02:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.g10,
                disabledBackgroundColor: DealiColor.g10,
                defaultTextColor: DealiColor.g80,
                disabledTextColor: DealiColor.g50
            )
        case .secondary03:
            return ButtonColor(
                defaultBackgroundColor: DealiColor.g10,
                disabledBackgroundColor: DealiColor.g10,
                defaultTextColor: DealiColor.g70,
                disabledTextColor: DealiColor.g50
            )
        }
    }
}


public enum FilledTonal: ButtonSizeConfig {
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

final public class btnFilledTonalLargePrimary01: SystemButton {
    public init() {
        super.init(color: FilledTonalColor.primary01, size: FilledTonal.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargePrimary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.primary02, size: FilledTonal.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary01: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary01, size: FilledTonal.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary02, size: FilledTonal.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalLargeSecondary03: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary03, size: FilledTonal.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnFilledTonalMediumPrimary01: SystemButton {
    public init() {
        super.init(color: FilledTonalColor.primary01, size: FilledTonal.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalMediumPrimary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.primary02, size: FilledTonal.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalMediumSecondary01: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary01, size: FilledTonal.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalMediumSecondary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary02, size: FilledTonal.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalMediumSecondary03: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary03, size: FilledTonal.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalSmallPrimary01: SystemButton {
    public init() {
        super.init(color: FilledTonalColor.primary01, size: FilledTonal.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalSmallPrimary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.primary02, size: FilledTonal.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalSmallSecondary01: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary01, size: FilledTonal.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalSmallSecondary02: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary02, size: FilledTonal.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnFilledTonalSmallSecondary03: SystemButton {
    
    public init() {
        super.init(color: FilledTonalColor.secondary03, size: FilledTonal.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
