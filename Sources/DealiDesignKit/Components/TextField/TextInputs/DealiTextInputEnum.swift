//
//  File.swift
//  
//
//  Created by hoji on 2023/11/02.
//

import UIKit

public enum ETextInputStatus: Equatable {
    case normal
    case focusIn
    case focusOut
    case disabled
    case readOnly
}

public enum ETextInputErrorStatus: Equatable {
    case none
    case error(String?)
}

public enum ETextInputRightViewType: Equatable {
    case none
    case timer
    case custom(_ image: UIImage?)
}

public enum ETextInputTextFormatType {
    case normal
    case email
    case url
    case number
    case phone
    case price
    case password
}

extension ETextInputStatus {
    var backgroundColor: UIColor {
        switch self {
        case .disabled:
            return .g10
        case .readOnly:
            return .g05
        default:
            return .primary04
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .focusIn:
            UIColor.g100.cgColor
        case .readOnly:
            self.backgroundColor.cgColor
        default:
            UIColor.g20.cgColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .disabled:
            return .g50
        case .readOnly:
            return .g80
        default:
            return .g100
        }
    }
}

extension ETextInputErrorStatus {
    var textColor: UIColor {
        return .g100
    }
    
    var backgroundColor: UIColor {
        return .primary04
    }
    
    var borderColor: CGColor {
        switch self {
        case .error:
            UIColor.error.cgColor
        default:
            UIColor.g20.cgColor
        }
    }
}
