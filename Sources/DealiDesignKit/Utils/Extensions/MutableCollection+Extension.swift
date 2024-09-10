//
//  Collection+Extension.swift
//
//
//  Created by 이창호 on 9/3/24.
//

import Foundation

extension MutableCollection {
    /**
     설명: Collection이 비어있지 않은지 여부를 나타내는 Boolean 값
     - isNotEmpty를 사용하면 collection의 count가 0 초과인지 확인하지 않아도 알 수 있습니다.
     - isEmpty 값의 반대 값을 반환합니다.
     */
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    /**
     설명: 안전하게 collection을 조회하기 위해 사용합니다.
     - collection의 range를 벗어나는 index 조회 시  nil을 반환하여 앱이 죽지 않도록 분기처리합니다.
     */
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
