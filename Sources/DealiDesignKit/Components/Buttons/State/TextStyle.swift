//
//  TextStyle.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public enum TextPrimary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary01
        case .hoverAndPressed:
            return DealiColor.primary02
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }
}

public enum TextPrimary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary04
        case .hoverAndPressed:
            return DealiColor.primary04
        case .disabled:
            return DealiColor.w50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }
}



public enum TextSecondary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.secondary01
        case .hoverAndPressed:
            return DealiColor.secondary02
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }
}

public enum TextSecondary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g100
        case .hoverAndPressed:
            return DealiColor.g100
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }

}


public enum TextSecondary03State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g80
        case .hoverAndPressed:
            return DealiColor.g100
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }

}


public enum TextSecondary04State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g70
        case .hoverAndPressed:
            return DealiColor.g100
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }

}

public enum TextSecondary05State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor { return UIColor.clear }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g60
        case .hoverAndPressed:
            return DealiColor.g100
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return UIColor.clear.cgColor }
}
