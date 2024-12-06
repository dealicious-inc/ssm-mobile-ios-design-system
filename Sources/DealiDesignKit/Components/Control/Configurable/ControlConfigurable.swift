//
//  ControlConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import Foundation

/**
 설명: 버튼, 칩 configure 추상화
 */
protocol ControlConfigurable {
    associatedtype Status
    associatedtype Style = ControlStyleProtocol
    associatedtype Size = ControlSizeProtocol
    
    var status: Status { get set }
    
    var style: Style { get }
    var size: Size { get }
    
    func updateAppearance()
}

protocol ControlStyleProtocol {
    associatedtype ColorProvider = ControlColorPrivider
    var radiusProvider: RadiusProvider { get }
    var colorProvider: ColorProvider { get }
}

protocol ControlSizeProtocol {
    var height: CGFloat { get }
}

protocol ControlColorProtocol {
    
}

protocol ControlColorPrivider {
    associatedtype Status
    associatedtype Color = ControlColorProtocol
    func getColor(for status: Status) -> Color
}
