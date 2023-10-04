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
    case secondary01
    case secondary02
    case secondary03
    case secondary04
    case secondary05
    
    public var attribute: ButtonColor {
        switch self {
        case .primary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor:  .clear,
                defaultTextColor: DealiColor.primary01,
                disabledTextColor: DealiColor.g50
            )
        case .primary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.primary04,
                disabledTextColor: DealiColor.w50
            )
        case .secondary01:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.secondary01,
                disabledTextColor: DealiColor.g50
            )
        case .secondary02:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g100,
                disabledTextColor: DealiColor.g50
            )
        case .secondary03:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g80,
                disabledTextColor: DealiColor.g50
            )
        case .secondary04:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g70,
                disabledTextColor: DealiColor.g50
            )
        case .secondary05:
            return ButtonColor(
                defaultBackgroundColor: .clear,
                disabledBackgroundColor: .clear,
                defaultTextColor: DealiColor.g60,
                disabledTextColor: DealiColor.g50
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
                font: UIFont.b2r14,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 13.0)
            )
        case .small:
            return ButtonSize(
                font: UIFont.b3r13,
                padding: DealiButtonPadding(horizontal: 16.0, vertical: 7.0)
            )
        }
        
    }
}

final public class btnTextLargePrimary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.primary01, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargePrimary02: SystemButton {

    public init() {
        super.init(color: TextColor.primary02, size: TextSize.large)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary01, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary02: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary02, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary03: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary03, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary04: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary04, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextLargeSecondary05: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary05, size: TextSize.large)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnTextMediumPrimary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.primary01, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumPrimary02: SystemButton {

    public init() {
        super.init(color: TextColor.primary02, size: TextSize.medium)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumSecondary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary01, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumSecondary02: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary02, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumSecondary03: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary03, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumSecondary04: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary04, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextMediumSecondary05: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary05, size: TextSize.medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final public class btnTextSmallPrimary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.primary01, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallPrimary02: SystemButton {

    public init() {
        super.init(color: TextColor.primary02, size: TextSize.small)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallSecondary01: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary01, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallSecondary02: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary02, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallSecondary03: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary03, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallSecondary04: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary04, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class btnTextSmallSecondary05: SystemButton {
    
    public init() {
        super.init(color: TextColor.secondary05, size: TextSize.small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
