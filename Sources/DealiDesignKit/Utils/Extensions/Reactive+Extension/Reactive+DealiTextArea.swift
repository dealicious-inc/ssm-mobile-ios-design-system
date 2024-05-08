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
    public var editingDidEnd: ControlEvent<Void> {
        return base.textField.rx.didEndEditing
    }
    
    public var editingDidBegin: ControlEvent<Void> {
        return base.textField.rx.didBeginEditing
    }
}

extension Reactive where Base: DealiTextArea {

    public var leftButtonTapped: ControlEvent<Void>? {
        return base.leftButton?.rx.tap
    }
    
    public var rightButtonTap: ControlEvent<Void>? {
        return base.rightButton?.rx.tap
    }
}
