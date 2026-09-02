//
//  DealiSearchInputPreset.swift
//
//
//  Created by JohyeonYoon on 2026/01/20.
//

import UIKit

public enum DealiSearchInputPreset {
    /// 흰색 배경, 회색 테두리 스타일
    case searchInput01
    /// 회색 배경, 테두리 없음 스타일 (기존)
    case searchInput02
    
    // MARK: - Background Color
    var backgroundColor: UIColor {
        switch self {
        case .searchInput01:
            return .white
        case .searchInput02:
            return .g10
        }
    }
    
    // MARK: - Border
    var hasBorder: Bool {
        switch self {
        case .searchInput01:
            return true
        case .searchInput02:
            return false
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .searchInput01:
            return .g20
        case .searchInput02:
            return .clear
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .searchInput01:
            return 1.0
        case .searchInput02:
            return 0.0
        }
    }
}
