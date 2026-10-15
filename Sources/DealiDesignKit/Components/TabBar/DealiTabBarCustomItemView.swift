//
//  DealiTabBarCustomItemView.swift
//
//
//  Created by 이창호 on 10/8/26.
//

import UIKit

/**
 설명: tabBarCustom 아이템 뷰의 기반 클래스. 앱이 상속해 내용을 그리고, 탭바는 선택 상태와 폭만 다룬다.

 하위 클래스가 할 일
 - `calculateInstrinsicSize()`를 override해 아이템 폭·높이를 돌려준다. 탭바는 이 width를 셀 폭으로 쓴다.
 - `isSelected`의 didSet에서 선택/비선택 색과 폰트를 바꾼다. 탭바가 탭 전환 때마다 세팅한다.
 - 터치는 탭바 셀이 받으므로 내부 컨트롤에 액션을 달지 않는다.

 ```swift
 final class CountChipItemView: DealiTabBarCustomItemView {
     private let chip = DealiControl.chipFilledMedium04()

     override var isSelected: Bool {
         didSet {
             self.chip.isSelected = self.isSelected
             self.updateTitle()
         }
     }

     init(title: String, count: Int) {
         super.init(frame: .zero)
         self.addSubview(self.chip)
         self.chip.snp.makeConstraints { $0.edges.equalToSuperview() }
     }

     override func calculateInstrinsicSize() -> CGSize {
         return self.chip.fixedSize
     }
 }
 ```
 */
open class DealiTabBarCustomItemView: DealiCustomView {
    
    /// 탭바가 선택 상태를 바꿀 때 세팅한다. 하위 클래스는 didSet에서 색·폰트를 갱신한다.
    open var isSelected: Bool = false
    
    /// 탭바가 셀 폭으로 쓰는 값. 기본은 `calculateInstrinsicSize()`의 width다. 폭 계산이 다른 뷰만 override한다.
    open var itemWidth: CGFloat {
        return self.calculateInstrinsicSize().width
    }
}
