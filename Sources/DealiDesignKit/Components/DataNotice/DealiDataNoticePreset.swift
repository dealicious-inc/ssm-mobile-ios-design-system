//
//  DealiDataNoticePreset.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiDataNoticeTitlePreset: Equatable {
    case bold
    case regular
    
    var font: UIFont {
        if case .bold = self {
            return .b3sb13
        }
        return .b3r13
    }
    
    var textColor: UIColor {
        if case .bold = self {
            return DealiColor.g100
        }
        
        return DealiColor.g80
    }
}

public enum DealiDataNoticePreset: Equatable {
    case bullet
    case numbering
    case html
    
    var font: UIFont {
        return .b3r13
    }
    
    var textColor: UIColor {
        return DealiColor.g80
    }
}
