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
    public static let g05: UIColor = GrayColor.G05.color
    public static let g10: UIColor = GrayColor.G10.color
    public static let g20: UIColor = GrayColor.G20.color
    public static let g30: UIColor = GrayColor.G30.color
    public static let g40: UIColor = GrayColor.G40.color
    public static let g50: UIColor = GrayColor.G50.color
    public static let g60: UIColor = GrayColor.G60.color
    public static let g70: UIColor = GrayColor.G70.color
    public static let g80: UIColor = GrayColor.G80.color
    public static let g100: UIColor = GrayColor.G100.color

    public static let error: UIColor = ServiceColor.error.color
    public static let warning: UIColor = ServiceColor.warning.color
    public static let linkAndInfo: UIColor = ServiceColor.linkAndInfo.color
    public static let success: UIColor = ServiceColor.success.color
    
    /// Etc
    public static let etc01: UIColor = EtcColor.Etc01.color
    public static let etc02: UIColor = EtcColor.Etc02.color
    public static let etc03: UIColor = EtcColor.Etc03.color
    public static let etc04: UIColor = EtcColor.Etc04.color
    public static let etc05: UIColor = EtcColor.Etc05.color
    public static let etc06: UIColor = EtcColor.Etc06.color
    public static let etc07: UIColor = EtcColor.Etc07.color
    public static let etc08: UIColor = EtcColor.Etc08.color
    public static let etc09: UIColor = EtcColor.Etc09.color
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
    case G05 = 0xF6F6F7
    case G10 = 0xF5F6FB
    case G20 = 0xEBEEF6
    case G30 = 0xDFE3ED
    case G40 = 0xD0D6E1
    case G50 = 0xBEC5D2
    case G60 = 0xA6ADBD
    case G70 = 0x8F97A7
    case G80 = 0x686E7B
    case G100 = 0x222222
}

enum ServiceColor: Int, ColorConfigurable {
    case error = 0xFA1818
    case warning = 0xFFD600
    case linkAndInfo = 0x2B66FD
    case success = 0x1BDA17
}

enum EtcColor: Int, ColorConfigurable {
    case Etc01
    case Etc02
    case Etc03
    case Etc04
    case Etc05
    case Etc06
    case Etc07
    case Etc08
    case Etc09
    
    var rgb: Int {
        switch self {
        case .Etc01:
            return 0x000000
        case .Etc02:
            return 0x000000
        case .Etc03:
            return 0x000000
        case .Etc04:
            return 0xFFFFFF
        case .Etc05:
            return 0xFFFFFF
        case .Etc06:
            return 0x000000
        case .Etc07:
            return 0xFFFFFF
        case .Etc08:
            return 0xFFFFFF
        case .Etc09:
            return 0xFFFFFF
        }
    }
    
    var alpha: Double {
        switch self {
        case .Etc01:
            return 0.1
        case .Etc02:
            return 0.2
        case .Etc03:
            return 0.4
        case .Etc04:
            return 0.2
        case .Etc05:
            return 0.5
        case .Etc06:
            return 0.7
        case .Etc07:
            return 0.9
        case .Etc08:
            return 0.05
        case .Etc09:
            return 0.1
        }
    }
}
