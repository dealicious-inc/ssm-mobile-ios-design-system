//
//  UIView+Rx.swift
//
//
//  Created by 윤조현 on 2023/06/21.
//

import UIKit
import RxSwift
import RxGesture

public extension Reactive where Base: UIView {
    func tapGestureOnTop() -> TapControlEvent {
        return self.tapGesture { _, delegate in
            delegate.simultaneousRecognitionPolicy = .never
        }
    }
}
