//
//  DealiDescriptionPreset.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiDescriptionPreset: Equatable {
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
