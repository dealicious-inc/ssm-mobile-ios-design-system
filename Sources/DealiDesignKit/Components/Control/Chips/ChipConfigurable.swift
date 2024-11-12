//
//  ChipConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import UIKit

protocol ChipConfigurable {
    var status: DealiChipStatus { get set }
    var radius: CGFloat { get }
    
    var style: ChipStyleProtocol { get }
    var size: ChipSizeProtoocol { get }
    
    func updateAppearance()
}

protocol ChipStyleProtocol {
    var radius: ChipRadiusType { get }
    var colors: ChipColorsProtocol { get }
}

protocol ChipSizeProtoocol {
    var height: CGFloat { get }
    var imageSize: CGSize { get }
    var placeholderInset: CGFloat { get }
    var titleFont: FontProvider { get }
}

protocol ChipColorsProtocol {
    func getColor(for status: DealiChipStatus) -> ChipColorProtocol
}

protocol ChipColorProtocol {
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor? { get }
}

enum ChipRadiusType {
    case none
    case fixed(_ radius: CGFloat)
    case capsule
}

protocol FontProvider {
    var systemFont: UIFont { get }
    func makeBolder() -> UIFont
}
