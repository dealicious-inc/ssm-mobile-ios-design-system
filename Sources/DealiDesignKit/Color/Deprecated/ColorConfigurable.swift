//
//  ColorConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 10/18/24.
//

import UIKit
import SwiftUI

protocol ColorConfigurable: RawRepresentable where RawValue == Int {
    var color: UIColor { get }
    var rgb: Int { get }
    var alpha: Double { get }
}

extension ColorConfigurable {
    var color: UIColor {
        return UIColor(rgb: self.rgb, alpha: self.alpha)
    }
    
    var rgb: Int { return self.rawValue }
    
    var alpha: Double { return 1.0 }
}

enum PrimaryColor: Int, ColorConfigurable, SystemColorConfig {
    case primary01 = 0xFB4760
    case primary02 = 0xEC2843
    case primary03 = 0xFEECEF
    case primary04 = 0xFFFFFF
    case primary05 = 0x000000
}

enum SecondaryColor: Int, ColorConfigurable, SystemColorConfig {
    case secondary01 = 0x4759FB
    case secondary02 = 0x2B3EE6
    case secondary03 = 0xEAEFFF
    case secondary04 = 0xFF7C44
    case secondary05 = 0xFF6827
    case secondary06 = 0xFFECDB
}

enum GrayColor: Int, ColorConfigurable, SystemColorConfig {
    case g05 = 0xF6F6F7
    case g10 = 0xF5F6FB
    case g20 = 0xEBEEF6
    case g30 = 0xDFE3ED
    case g40 = 0xD0D6E1
    case g50 = 0xBEC5D2
    case g60 = 0xA6ADBD
    case g70 = 0x8F97A7
    case g80 = 0x686E7B
    case g100 = 0x222222
}

enum EtcColor: Int, ColorConfigurable, SystemColorConfig {
    case etc01
    case etc02
    case etc03
    case etc04
    case etc05
    case etc06
    case etc07
    case etc08
    case etc09
    
    case b70, b50, b40, b30, b20, b10, b5
    case w90, w70, w50, w30, w20, w15, w10, w5
    
    var rgb: Int {
        switch self {
        case .etc01, .etc02, .etc03, .etc06:
            return 0x000000
        case .etc04, .etc05, .etc07, .etc08, .etc09:
            return 0xFFFFFF
            
        case .b5, .b10, .b20, .b30, .b40, .b50, .b70:
            return 0x000000
        case .w90, .w70, .w50, .w30, .w20, .w15, .w10, .w5:
            return 0xFFFFFF
            
        }
    }
    
    var alpha: Double {
        switch self {
        case .etc01:
            return 0.1
        case .etc02:
            return 0.2
        case .etc03:
            return 0.4
        case .etc04:
            return 0.2
        case .etc05:
            return 0.5
        case .etc06:
            return 0.7
        case .etc07:
            return 0.9
        case .etc08:
            return 0.05
        case .etc09:
            return 0.1
            
        case .b70:
            return 0.70
        case .b50:
            return 0.50
        case .b40:
            return 0.40
        case .b30:
            return 0.30
        case .b20:
            return 0.20
        case .b10:
            return 0.10
        case .b5:
            return 0.05
        case .w90:
            return 0.90
        case .w70:
            return 0.70
        case .w50:
            return 0.50
        case .w30:
            return 0.30
        case .w20:
            return 0.20
        case .w15:
            return 0.15
        case .w10:
            return 0.10
        case .w5:
            return 0.05
        }
    }
}

enum ServiceColor: Int, ColorConfigurable, SystemColorConfig {
    case error = 0xFA1818
    case warning = 0xFFD600
    case linkAndInfo = 0x2B66FD
    case success = 0x1BDA17
}
