//
//  DealiColor.swift
//  
//
//  Created by Nam Jun Lee on 2023/05/19.
//

import UIKit

enum DealiColor: String, CaseIterable {
    case pink10, pink60, pink90
    
    case black10, black20, black40, black100
    
    case white20, white60, white100
    
    case blue10, blue70, blue90
    
    case orange10, orange50, orange60
    
    case gray10, gray20, gray30, gray40, gray50, gray60, gray70, gray80, gray100
    
    case error, info, waring, success
}

extension DealiColor {
    var color: UIColor {
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
