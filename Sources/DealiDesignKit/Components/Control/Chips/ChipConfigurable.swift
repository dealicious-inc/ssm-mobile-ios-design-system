//
//  ChipConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import UIKit
import SwiftUI

protocol ChipConfigurable: ControlConfigurable where Style == any ChipStyleProtocol,
                                                     Size == any ChipSizeProtoocol { }

protocol ChipStyleProtocol: ControlStyleProtocol {
    var radiusProvider: RadiusProvider { get }
}

protocol ChipSizeProtoocol: ControlSizeProtocol {
    var height: CGFloat { get }
    var imageSize: CGSize { get }
    var placeholderInset: CGFloat { get }
    var titleFont: FontProvider { get }
}

protocol ChipColorProtocol {
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor? { get }
}

enum ChipRadiusType: RadiusProvider {
    case none
    case fixed(_ radius: CGFloat)
    case capsule
    
    func getRadius(for height: CGFloat) -> CGFloat {
        switch self {
        case .none: return 0
        case let .fixed(radius):
            return radius
        case .capsule:
            return height / 2
        }
    }
}
