//
//  FilledTonalState.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public enum FilledTonalPrimary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .hoverAndPressed, .loading:
            return DealiColor.primary03
        case .disabled:
            return DealiColor.g20
        }
    }
    
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
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}

public enum FilledTonalPrimary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .hoverAndPressed, .loading:
            return DealiColor.w20
        case .disabled:
            return DealiColor.w20
        }
    }
    
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
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}

public enum FilledTonalSecondary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default,.loading:
            return DealiColor.g10
        case .hoverAndPressed:
            return DealiColor.g20
        case .disabled:
            return DealiColor.g10
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default:
            return DealiColor.g100
        case .hoverAndPressed:
            return DealiColor.g100
        case .disabled, .loading:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}

public enum FilledTonalSecondary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default,.loading:
            return DealiColor.g10
        case .hoverAndPressed:
            return DealiColor.g20
        case .disabled:
            return DealiColor.g10
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g80
        case .hoverAndPressed:
            return DealiColor.g80
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}


public enum FilledTonalSecondary03State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default,.loading:
            return DealiColor.g10
        case .hoverAndPressed:
            return DealiColor.g20
        case .disabled:
            return DealiColor.g10
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.g70
        case .hoverAndPressed:
            return DealiColor.g70
        case .disabled:
            return DealiColor.g50
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}

