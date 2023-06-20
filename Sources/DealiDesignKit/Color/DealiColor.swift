//
//  DealiColor.swift
//  
//
//  Created by Nam Jun Lee on 2023/05/19.
//

import UIKit

public struct DColor {
    
    // 사용의 편의를 위함
    public static let primary01: UIColor = Primary.primary01.color
    public static let primary02: UIColor = Primary.primary02.color
    public static let primary03: UIColor = Primary.primary03.color
    public static let primary04: UIColor = Primary.primary04.color
    public static let primary05: UIColor = Primary.primary05.color
    
    public static let secondary01: UIColor = Secondary.secondary01.color
    public static let secondary02: UIColor = Secondary.secondary02.color
    public static let secondary03: UIColor = Secondary.secondary03.color
    public static let secondary04: UIColor = Secondary.secondary04.color
    public static let secondary05: UIColor = Secondary.secondary05.color
    public static let secondary06: UIColor = Secondary.secondary06.color
    
    public static let text01: UIColor = TextColor.text01.color
    public static let text02: UIColor = TextColor.text02.color
    public static let text03: UIColor = TextColor.text03.color
    public static let text04: UIColor = TextColor.text04.color
    public static let text05: UIColor = TextColor.text05.color
    
    public static let divider01: UIColor = Divider.divider01.color
    public static let divider02: UIColor = Divider.divider02.color
    public static let divider03: UIColor = Divider.divider03.color
    
    public static let line01: UIColor = Line.line01.color
    public static let line02: UIColor = Line.line02.color
    public static let line03: UIColor = Line.line03.color
    public static let line04: UIColor = Line.line04.color
    
    public static let bg01: UIColor = BG.bg01.color
    public static let bg02: UIColor = BG.bg02.color
    public static let bg03: UIColor = BG.bg03.color
    public static let bg04: UIColor = BG.bg04.color
    public static let bg05: UIColor = BG.bg05.color
    public static let bg06: UIColor = BG.bg06.color
    public static let bg07: UIColor = BG.bg07.color
    public static let bg08: UIColor = BG.bg08.color

    public static let error: UIColor = Service.error.color
    public static let warning: UIColor = Service.warning.color
    public static let linkAndInfo: UIColor = Service.linkAndInfo.color
    public static let success: UIColor = Service.success.color
}

protocol ColorConfigurable: RawRepresentable where RawValue == Int {
    var color: UIColor { get }
}

extension ColorConfigurable {
    var color: UIColor {
        return UIColor(rgb: self.rawValue)
    }
}

enum Primary: Int, ColorConfigurable {
    case primary01 = 0xFB4760
    case primary02 = 0xEC2843
    case primary03 = 0xFEECEF
    case primary04 = 0xFFFFFF
    case primary05 = 0x000000
}

enum Secondary: Int, ColorConfigurable {
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

enum Divider: Int, ColorConfigurable {
    case divider01 = 0xDFE3ED
    case divider02 = 0xEBEEF6
    case divider03 = 0xF5F6FB
}

enum Line: Int, ColorConfigurable {
    case line01 = 0x222222
    case line02 = 0xBEC5D2
    case line03 = 0xDFE3ED
    case line04 = 0xEBEEF6
}

enum BG: Int, ColorConfigurable {
    case bg01 = 0x222222
    case bg02 = 0xA6ADBD
    case bg03 = 0xBEC5D2
    case bg04 = 0xD0D6E1
    case bg05 = 0xDFE3ED
    case bg06 = 0xEBEEF6
    case bg07 = 0xF5F6FB
    case bg08 = 0xF6F6F7
}

enum Service: Int, ColorConfigurable {
    case error = 0xFA1818
    case warning = 0xFFD600
    case linkAndInfo = 0x2B66FD
    case success = 0x1BDA17
}


// MARK: - 색 계열별 분류
public enum DealiColor: String, CaseIterable {
    case pink10, pink60, pink90
    
    case black10, black20, black40, black100
    
    case white20, white60, white100
    
    case blue10, blue70, blue90
    
    case orange10, orange50, orange60
    
    case gray10, gray20, gray30, gray40, gray50, gray60, gray70, gray80, gray100
    
    case error, info, waring, success
}

extension DealiColor {
    public  var color: UIColor {
        switch self {
        case .pink10:
            return UIColor(rgb: 0xFEECEF)
        case .pink60:
            return UIColor(rgb: 0xFB4760)
        case .pink90:
            return UIColor(rgb: 0xEC2843)
        case .black10:
            return UIColor(rgb: 0x000000).withAlphaComponent(0.1)
        case .black20:
            return UIColor(rgb: 0x000000).withAlphaComponent(0.2)
        case .black40:
            return UIColor(rgb: 0x000000).withAlphaComponent(0.4)
        case .black100:
            return UIColor(rgb: 0x000000)
        case .white20:
            return UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.2)
        case .white60:
            return UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.6)
        case .white100:
            return UIColor(rgb: 0xFFFFFF)
        case .blue10:
            return UIColor(rgb: 0xEAEFFF)
        case .blue70:
            return UIColor(rgb: 0x3668F4)
        case .blue90:
            return UIColor(rgb: 0x0E46E4)
        case .orange10:
            return UIColor(rgb: 0xFFECDB)
        case .orange50:
            return UIColor(rgb: 0xFF7C44)
        case .orange60:
            return UIColor(rgb: 0xFF6827)
        case .gray10:
            return UIColor(rgb: 0xF5F6FB)
        case .gray20:
            return UIColor(rgb: 0xEBEEF6)
        case .gray30:
            return UIColor(rgb: 0xD0D6E1)
        case .gray40:
            return UIColor(rgb: 0xD0D6E1)
        case .gray50:
            return UIColor(rgb: 0xBEC5D2)
        case .gray60:
            return UIColor(rgb: 0xA6ADBD)
        case .gray70:
            return UIColor(rgb: 0x8F97A7)
        case .gray80:
            return UIColor(rgb: 0x686E7B)
        case .gray100:
            return UIColor(rgb: 0x222222)
        case .error:
            return UIColor(rgb: 0xFA1818)
        case .info:
            return UIColor(rgb: 0x2B66FD)
        case .waring:
            return UIColor(rgb: 0xFFD600)
        case .success:
            return UIColor(rgb: 0x1BDA17)
        }
    }
}
