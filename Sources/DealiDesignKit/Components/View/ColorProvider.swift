//
//  ColorProvider.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/21/25.
//

import Foundation

protocol ColorProvider {
    associatedtype Status: Equatable
    associatedtype Color
    func getColor(for status: Status) -> Color
}
