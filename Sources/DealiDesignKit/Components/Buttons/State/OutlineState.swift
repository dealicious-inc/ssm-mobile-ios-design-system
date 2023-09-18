//
//  OutlineState.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public enum OutlinePrimary01State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary01.cgColor
        case .hoverAndPressed:
            return DealiColor.primary02.cgColor
        case .disabled:
            return DealiColor.g30.cgColor
        }
        
    }
}

public enum OutlinePrimary02State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary04.cgColor
        case .hoverAndPressed:
            return DealiColor.primary04.cgColor
        case .disabled:
            return DealiColor.w50.cgColor
        }
        
    }
}



public enum OutlineSecondary01State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.secondary01.cgColor
        case .hoverAndPressed:
            return DealiColor.secondary02.cgColor
        case .disabled:
            return DealiColor.g30.cgColor
        }
        
    }
}

public enum OutlineSecondary02State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.g100.cgColor
        case .hoverAndPressed:
            return DealiColor.g100.cgColor
        case .disabled:
            return DealiColor.g30.cgColor
        }
        
    }
}


public enum OutlineSecondary03State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.g30.cgColor
        case .hoverAndPressed:
            return DealiColor.g50.cgColor
        case .disabled:
            return DealiColor.g20.cgColor
        }
        
    }
}


public enum OutlineSecondary04State: ButtonState {
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
    
    public var borderColor: CGColor {
        switch self {
        case .default, .loading:
            return DealiColor.g30.cgColor
        case .hoverAndPressed:
            return DealiColor.g50.cgColor
        case .disabled:
            return DealiColor.g20.cgColor
        }
        
    }
}
