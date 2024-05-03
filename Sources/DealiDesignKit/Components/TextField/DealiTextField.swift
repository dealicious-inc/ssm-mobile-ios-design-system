//
//  DealiTextField.swift
//
//
//  Created by 윤조현 on 2024/05/02.
//

import UIKit
import RxSwift
import RxCocoa

/**
 텍스트 필드(Text Fields)는 사용자가 텍스트 입력 및 확인 시 활용되는 컴포넌트입니다.
 한 줄 입력인 텍스트 필드(Input)와 여러 줄 입력인 텍스트 영역(Text Area)으로 나뉩니다.
 */
public protocol DealiTextField {
    
    associatedtype T: UITextInput
    var textField: T { get }
}

protocol DealiTextFieldConfig {
    func setNormalHelperText(text: String?)
    func setError(for errorMessage: String?)
}


public extension Reactive where Base: DealiTextField {
    var inputStatus: PublishRelay<ETextInputStatus> {
        return PublishRelay()
    }
}

