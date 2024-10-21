//
//  SystemColorConfig.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 10/21/24.
//

import SwiftUI
import UIKit

/*
 Color 를 만들기 위함.
 
 SystemColor
 - config: ColorConfigurable
 - color: config.makeColor()
 
 SystemColorConfig
 - makeColor
  */


protocol SystemColorConfig {
    func uiColor() -> UIColor
    
    var rgb: Int { get }
    var alpha: Double { get }
}

extension SystemColorConfig {
    func uiColor() -> UIColor {
        .init(rgb: rgb, alpha: alpha)
    }
}
