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
    
    public static let secondary01: UIColor = SecondaryColor.secondary01.color
    public static let secondary02: UIColor = SecondaryColor.secondary02.color
    public static let secondary03: UIColor = SecondaryColor.secondary03.color
    public static let secondary04: UIColor = SecondaryColor.secondary04.color
    public static let secondary05: UIColor = SecondaryColor.secondary05.color
    public static let secondary06: UIColor = SecondaryColor.secondary06.color
    
    public static let text01: UIColor = TextColor.text01.color
    public static let text02: UIColor = TextColor.text02.color
    public static let text03: UIColor = TextColor.text03.color
    public static let text04: UIColor = TextColor.text04.color
    public static let text05: UIColor = TextColor.text05.color
    
    public static let divider01: UIColor = DividerColor.divider01.color
    public static let divider02: UIColor = DividerColor.divider02.color
    public static let divider03: UIColor = DividerColor.divider03.color
    
    public static let line01: UIColor = LineColor.line01.color
    public static let line02: UIColor = LineColor.line02.color
    public static let line03: UIColor = LineColor.line03.color
    public static let line04: UIColor = LineColor.line04.color
    
    public static let bg01: UIColor = BGColor.bg01.color
    public static let bg02: UIColor = BGColor.bg02.color
    public static let bg03: UIColor = BGColor.bg03.color
    public static let bg04: UIColor = BGColor.bg04.color
    public static let bg05: UIColor = BGColor.bg05.color
    public static let bg06: UIColor = BGColor.bg06.color
    public static let bg07: UIColor = BGColor.bg07.color
    public static let bg08: UIColor = BGColor.bg08.color

    public static let error: UIColor = ServiceColor.error.color
    public static let warning: UIColor = ServiceColor.warning.color
    public static let linkAndInfo: UIColor = ServiceColor.linkAndInfo.color
    public static let success: UIColor = ServiceColor.success.color
    
    public static let etc01: UIColor = EtcColor.etc01.color
    public static let etc02: UIColor = EtcColor.etc02.color
    public static let etc03: UIColor = EtcColor.etc03.color
    public static let etc04: UIColor = EtcColor.etc04.color
    public static let etc05: UIColor = EtcColor.etc05.color
}

protocol ColorConfigurable: RawRepresentable where RawValue == Int {
    var color: UIColor { get }
    var rgb: Int { get }
    var alpha: Double { get }
}

extension ColorConfigurable {
    var color: UIColor {
        return UIColor(rgb: self.rawValue, alpha: self.alpha)
    }
    
    var rgb: Int { return self.rawValue }
    
    var alpha: Double { return 1.0 }
}

enum PrimaryColor: Int, ColorConfigurable {
    case primary01 = 0xFB4760
    case primary02 = 0xEC2843
    case primary03 = 0xFEECEF
    case primary04 = 0xFFFFFF
    case primary05 = 0x000000
}

enum SecondaryColor: Int, ColorConfigurable {
    case secondary01 = 0x3668F4
    case secondary02 = 0x0E46E4
    case secondary03 = 0xEAEFFF
    case secondary04 = 0xFF7C44
    case secondary05 = 0xFF6827
    case secondary06 = 0xFFECDB
}

enum TextColor: Int, ColorConfigurable {
   case text01 = 0x222222
   case text02 = 0x686E7B
   case text03 = 0x8F97A7
   case text04 = 0xA6ADBD
   case text05 = 0xBEC5D2
}

enum DividerColor: Int, ColorConfigurable {
    case divider01 = 0xDFE3ED
    case divider02 = 0xEBEEF6
    case divider03 = 0xF5F6FB
}

enum LineColor: Int, ColorConfigurable {
    case line01 = 0x222222
    case line02 = 0xBEC5D2
    case line03 = 0xDFE3ED
    case line04 = 0xEBEEF6
}

enum BGColor: Int, ColorConfigurable {
    case bg01 = 0x222222
    case bg02 = 0xA6ADBD
    case bg03 = 0xBEC5D2
    case bg04 = 0xD0D6E1
    case bg05 = 0xDFE3ED
    case bg06 = 0xEBEEF6
    case bg07 = 0xF5F6FB
    case bg08 = 0xF6F6F7
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
        }
    }
}
