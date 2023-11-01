//
//  UIControl+Reactiive.swift
//  
//
//  Created by 윤조현 on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIControl {
    
    var tap: ControlEvent<Void> {
        controlEvent(.touchUpInside)
    }
}
