//
//  File.swift
//  
//
//  Created by JohyeonYoon on 2023/09/18.
//

import UIKit

public enum FilledPrimary01State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public init() {
        self = .default
    }
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary01
        case .hoverAndPressed:
            return DealiColor.primary02
        case .disabled:
            return DealiColor.g40
            
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.primary04
        case .hoverAndPressed:
            return DealiColor.primary04
        case .disabled:
            return DealiColor.primary04
        }
    }
    
    public var borderColor: CGColor { return DealiColor.primary04.cgColor }
}

public enum FilledPrimary02State: ButtonState {
    case `default`
    case hoverAndPressed
    case disabled
    case loading
    
    public var backgroundColor: UIColor {
        switch self {
        case .default, .loading:
            return DealiColor.b40
        case .hoverAndPressed:
            return DealiColor.b70
        case .disabled:
            return DealiColor.b20
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
