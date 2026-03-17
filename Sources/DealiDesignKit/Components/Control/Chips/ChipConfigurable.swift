//
//  ChipConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import UIKit
import SwiftUI

protocol ChipConfigurable: ControlConfigurable where Variant == any ChipStyleProtocol,
                                                     Size == any ChipSizeProtoocol { }

protocol ChipStyleProtocol: ControlStyleProtocol {
    var radiusProvider: RadiusProvider { get }
}

protocol ChipSizeProtoocol: ControlSizeProtocol {
    var height: CGFloat { get }
    var imageSize: CGSize { get }
    var placeholderInset: CGFloat { get }
    var titleFont: FontProvider { get }
    /// 사이즈별 패딩 오버라이드 (nil이면 ImageChip 기본값 사용)
    var leftPadding: CGFloat? { get }
    var rightPadding: CGFloat? { get }
    var verticalPadding: CGFloat? { get }
    var interItemSpacing: CGFloat? { get }
}

extension ChipSizeProtoocol {
    var leftPadding: CGFloat? { nil }
    var rightPadding: CGFloat? { nil }
    var verticalPadding: CGFloat? { nil }
    var interItemSpacing: CGFloat? { nil }
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
