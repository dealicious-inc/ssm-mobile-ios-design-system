//
//  DealiDataNoticePreset.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiDataNoticeTitleType: Equatable {
    case bold
    case regular
}

public enum DealiDataNoticePreset: Equatable {
    case bullet
    case numbering
    case html
    case titleAndBullet(titleType: DealiDataNoticeTitleType)
    case titleAndNumbering(titleType: DealiDataNoticeTitleType)
    
    var font: UIFont {
        return .b3r13
    }
    
    var textColor: UIColor {
        return DealiColor.g80
    }
    
    var titleFont: UIFont {
        if case .titleAndBullet(let titleType) = self {
            switch titleType {
            case .bold:
                return .b3sb13
            default:
                break
            }
        } else if case .titleAndBullet(let titleType) = self {
            switch titleType {
            case .bold:
                return .b3sb13
            default:
                break
            }
        }
        
        return .b3r13
    }
    
    var titleTextColor: UIColor {
        if case .titleAndBullet(let titleType) = self {
            switch titleType {
            case .bold:
                return DealiColor.g100
            default:
                break
            }
        } else if case .titleAndBullet(let titleType) = self {
            switch titleType {
            case .bold:
                return DealiColor.g100
            default:
                break
            }
        }
        
        return DealiColor.g80
    }
}
