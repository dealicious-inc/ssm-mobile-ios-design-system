//
//  OutlineButton.swift
//
//
//  Created by 윤조현 on 2023/09/21.
//

import UIKit

public enum OutlineColor: ButtonColorConfig {
    case primary01
    case primary02
    case secondary01
    case secondary02
    case secondary03
    case secondary04

    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor:  .clear,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.primary01,
                disabledBorderColor: DealiColor.g30
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50,
                defaultBorderColor: DealiColor.primary04,
                disabledBorderColor: DealiColor.w50
            )
        case .secondary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.secondary01,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.secondary01,
                disabledBorderColor: DealiColor.g30
            )
        case .secondary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g100,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.g100,
                disabledBorderColor: DealiColor.g30
            )
        case .secondary03:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g100,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.g30,
                disabledBorderColor: DealiColor.g20
            )
        case .secondary04:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g80,
                disabledTextColor: DealiColor.g50,
                defaultBorderColor: DealiColor.g30,
                disabledBorderColor: DealiColor.g20
            )
        }
    }
}

public enum OutlineSize: ButtonSizeConfig {
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
                font: UIFont.b3sb13,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 7.0)
            )
        }
    }
}

final public class btnOutlineLargePrimary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary01, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargePrimary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary02, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary01, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary02, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary03: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary03, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineLargeSecondary04: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary04, size: OutlineSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnOutlineMediumPrimary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary01, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineMediumPrimary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary02, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineMediumSecondary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary01, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineMediumSecondary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary02, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineMediumSecondary03: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary03, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineMediumSecondary04: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary04, size: OutlineSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallPrimary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary01, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallPrimary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.primary02, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallSecondary01: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary01, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallSecondary02: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary02, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallSecondary03: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary03, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnOutlineSmallSecondary04: SystemButton {
    
    public init() {
        super.init(color: OutlineColor.secondary04, size: OutlineSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

