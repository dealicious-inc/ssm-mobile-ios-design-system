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

public enum ETextInputErrorToastType {
    /// 이모티콘을 입력했을경우
    case emoji
    /// 일력불가 텍스트를 입력했을 경우
    case restrictCharacter
    /// 최대 글자수를 넘어서 입력했을경우
    case maxLength
    /// 가격 범위를 넘어서 입력했을경우
    case priceRange
    case allowedCharacter
    /// 소수점이 먼저 입력되었을 경우
    case decimalPlaces
}
