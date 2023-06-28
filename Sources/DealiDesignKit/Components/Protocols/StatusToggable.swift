//
//  StatusToggable.swift
//
//
//  Created by 윤조현 on 2023/06/28.
//

import UIKit

/// 유저 액션에 따른 선택, 미선택 그리고 비활성 값을 가질 수 있는 UI 컴포넌트 상태 관리에 사용
///
/// `Checkbox`, `RadioButton`, `Switch` 등 컴포넌트의 상태관리에 사용
protocol StatusToggable {
    static func normal(isSelected: Bool) -> Self
    static var disabled: Self { get }
    
    mutating func changeStatus()
    var imageName: String { get }
    var textColor: UIColor { get }
}
