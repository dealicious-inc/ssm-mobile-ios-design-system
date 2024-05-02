//
//  Reactive+DealiTextArea.swift
//
//
//  Created by 윤조현 on 2024/05/02.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: DealiTextField, Base.T == UITextView {
    
    public var editingDidEnd: ControlEvent<()> {
        return base.textField.rx.didEndEditing
    }
    
    public var editingDidBegin: ControlEvent<()> {
        return base.textField.rx.didBeginEditing
    }
    
    
}
