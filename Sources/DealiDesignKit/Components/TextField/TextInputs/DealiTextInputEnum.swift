//
//  File.swift
//  
//
//  Created by hoji on 2023/11/02.
//

import Foundation
import UIKit

public enum ETextInputStatus: Equatable {
    case normal
    case focusIn
    case focusOut
    case error(_ errorMessage: String?)
    case disabled
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
