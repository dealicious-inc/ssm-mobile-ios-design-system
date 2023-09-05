//
//  DealiColor.swift
//  
//
//  Created by JohyeonYoon on 2023/07/11.
//

import UIKit

public struct DealiColor {
    
    // 사용의 편의를 위함
    public static let primary01: UIColor = PrimaryColor.primary01.color
    public static let primary02: UIColor = PrimaryColor.primary02.color
    public static let primary03: UIColor = PrimaryColor.primary03.color
    public static let primary04: UIColor = PrimaryColor.primary04.color
    public static let primary05: UIColor = PrimaryColor.primary05.color
    
    public static let primaryGradient: [UIColor] = Gradient.primaryGradient.colors
    
    public static let secondary01: UIColor = SecondaryColor.secondary01.color
    public static let secondary02: UIColor = SecondaryColor.secondary02.color
    public static let secondary03: UIColor = SecondaryColor.secondary03.color
    public static let secondary04: UIColor = SecondaryColor.secondary04.color
    public static let secondary05: UIColor = SecondaryColor.secondary05.color
    public static let secondary06: UIColor = SecondaryColor.secondary06.color
    
    /// Gray
    public static let g05: UIColor = GrayColor.g05.color
    public static let g10: UIColor = GrayColor.g10.color
    public static let g20: UIColor = GrayColor.g20.color
    public static let g30: UIColor = GrayColor.g30.color
    public static let g40: UIColor = GrayColor.g40.color
    public static let g50: UIColor = GrayColor.g50.color
    public static let g60: UIColor = GrayColor.g60.color
    public static let g70: UIColor = GrayColor.g70.color
    public static let g80: UIColor = GrayColor.g80.color
    public static let g100: UIColor = GrayColor.g100.color

    public static let error: UIColor = ServiceColor.error.color
    public static let warning: UIColor = ServiceColor.warning.color
    public static let linkAndInfo: UIColor = ServiceColor.linkAndInfo.color
    public static let success: UIColor = ServiceColor.success.color
    
    /// Etc
    public static let etc01: UIColor = EtcColor.etc01.color
    public static let etc02: UIColor = EtcColor.etc02.color
    public static let etc03: UIColor = EtcColor.etc03.color
    public static let etc04: UIColor = EtcColor.etc04.color
    public static let etc05: UIColor = EtcColor.etc05.color
    public static let etc06: UIColor = EtcColor.etc06.color
    public static let etc07: UIColor = EtcColor.etc07.color
    public static let etc08: UIColor = EtcColor.etc08.color
    public static let etc09: UIColor = EtcColor.etc09.color
}

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

protocol ColorsConfigurable: RawRepresentable where RawValue == Int {
    var colors: [UIColor] { get }
    var gradient: [Int] { get }
}

extension ColorsConfigurable {
    var colors: [UIColor] {
        var colorArray: [UIColor] = []
        for hex in self.gradient {
            colorArray.append(UIColor(rgb: hex, alpha: 1.0))
        }
        return colorArray
    }
    
    //    var gradient: Int { return self.rawValue }
}

enum PrimaryColor: Int, ColorConfigurable {
    case primary01 = 0xFB4760
    case primary02 = 0xEC2843
    case primary03 = 0xFEECEF
    case primary04 = 0xFFFFFF
    case primary05 = 0x000000
}

enum Gradient: Int, ColorsConfigurable {
    case primaryGradient
    
    var gradient: [Int] {
        switch self {
        case .primaryGradient:
            return [0xFB4760, 0xFE1EA4]
        }
    }
}

enum SecondaryColor: Int, ColorConfigurable {
    case secondary01 = 0x4759FB
    case secondary02 = 0x2B3EE6
    case secondary03 = 0xEAEFFF
    case secondary04 = 0xFF7C44
    case secondary05 = 0xFF6827
    case secondary06 = 0xFFECDB
}

enum GrayColor: Int, ColorConfigurable {
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

enum ServiceColor: Int, ColorConfigurable {
    case error = 0xFA1818
    case warning = 0xFFD600
    case linkAndInfo = 0x2B66FD
    case success = 0x1BDA17
}

enum EtcColor: Int, ColorConfigurable {
    case etc01
    case etc02
    case etc03
    case etc04
    case etc05
    case etc06
    case etc07
    case etc08
    case etc09
    
    var rgb: Int {
        switch self {
        case .etc01:
            return 0x000000
        case .etc02:
            return 0x000000
        case .etc03:
            return 0x000000
        case .etc04:
            return 0xFFFFFF
        case .etc05:
            return 0xFFFFFF
        case .etc06:
            return 0x000000
        case .etc07:
            return 0xFFFFFF
        case .etc08:
            return 0xFFFFFF
        case .etc09:
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
        }
    }
}
