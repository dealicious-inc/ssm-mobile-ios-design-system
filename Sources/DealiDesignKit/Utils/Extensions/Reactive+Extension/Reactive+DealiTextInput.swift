//
//  Reactive+DealiTextInput.swift
//
//
//  Created by 윤조현 on 2024/05/02.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: DealiTextField, Base.T == UITextField {
    
    public func controlEvent(_ controlEvents: UIControl.Event) -> ControlEvent<()> {
        return base.textField.rx.controlEvent(controlEvents)
    }
    
    public var editingDidEnd: ControlEvent<()> {
        return base.textField.rx.controlEvent(.editingDidEnd)
    }
    
    /// return, next 키 등 눌렀을 때 포커스 조정 등의 처리를 위한 이벤트
    public var editingDidEndOnExit: ControlEvent<()> {
        return base.textField.rx.controlEvent(.editingDidEndOnExit)
    }
    
    /// 포커스 아웃 시 불리는 이벤트 [.editingDidEnd, .editingDidEndOnExit]
    public var editingDidFinish: ControlEvent<()> {
        return base.textField.rx.controlEvent([.editingDidEnd, .editingDidEndOnExit])
    }
    
    public var textEditingControlProperty: ControlProperty<String?> {
        return base.textField.rx.controlProperty(
            editingEvents: [.editingChanged, .valueChanged],
            getter: { textField in
                textField.text
            },
            setter: { textField, value in
                if base.textField.text != value {
                    base.textField.text = value
                }
            }
        )
    }
    
}
