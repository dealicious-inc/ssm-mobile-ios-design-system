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
    associatedtype Variant = ControlStyleProtocol
    associatedtype Size = ControlSizeProtocol
        
    var style: Variant { get }
    var size: Size { get }
}

protocol ControlStyleProtocol {
    associatedtype Provider = ColorPrivider
    var colorProvider: Provider { get }
}

protocol ControlSizeProtocol {
    var height: CGFloat { get }
}

protocol ColorPrivider {
    associatedtype Status
    associatedtype Color
    func getColor(for status: Status) -> Color
}
