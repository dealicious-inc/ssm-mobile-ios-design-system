//
//  GradientConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/30/24.
//

import UIKit

public protocol GradientConfigurable {
    var startPoint: CGPoint { get }
    var endPoint: CGPoint { get }
    
    var colors: [UIColor] { get }
    var location: [NSNumber] { get }
}

public extension GradientConfigurable {
    var startPoint: CGPoint {
        return CGPoint(x: 0.0, y: 0.5)
    }
    
    var endPoint: CGPoint {
        return CGPoint(x: 1.0, y: 0.5)
    }
    
    var location: [NSNumber] {
        return [0.0, 1.0]
    }
}

// MARK: - Implementation
public enum PrimaryGradient: GradientConfigurable {
    case gradient

    var startColor: UIColor {
        switch self {
        case .gradient:
            return UIColor(rgb: 0xFB493A, alpha: 1.0)
        }
    }
    
    var endColor: UIColor {
        switch self {
        case .gradient:
            return UIColor(rgb: 0xFE1EA4, alpha: 1.0)
        }
    }
    
    public var colors: [UIColor] {
        return [startColor, endColor]
    }
}

public enum MbsGradient: GradientConfigurable {
    case gradient01
    case gradient02
    
    var startColor: SystemColorConfig {
        return MBSColor.mbs01
    }
    
    var endColor: SystemColorConfig {
        return MBSColor.mbs02
    }
    
    public var colors: [UIColor] {
        return [startColor.uiColor(), endColor.uiColor()]
    }
    
    public var location: [NSNumber] {
        switch self {
        case .gradient01:
            return [0.31, 1.0]
        case .gradient02:
            return [0.2, 1.0]
        }
    }
    
    public var startPoint: CGPoint {
        switch self {
        case .gradient01:
            return CGPoint(x: 0.0, y: 0.45)
        case .gradient02:
            return CGPoint(x: 0.0, y: 0.0)
        }
    }
    
    public var endPoint: CGPoint {
        switch self {
        case .gradient01:
            return CGPoint(x: 1.0, y: 0.6 )
        case .gradient02:
            return CGPoint(x: 1, y: 1.5)
        }
    }
}
