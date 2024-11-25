//
//  RadiusProvider.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/12/24.
//

import Foundation

protocol RadiusProvider {
    func getRadius(for height: CGFloat) -> CGFloat
}
