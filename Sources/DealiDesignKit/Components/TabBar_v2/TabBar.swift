//
//  TabBar.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 11/6/24.
//

import Foundation

protocol TabBar {
    // 1. 탭바 눌러서 선택
    
    // 1.1. 아래 뷰컨 업데이트
    // 1.2. 탭바 선택값 반영
    // 1.3. 선택값 중앙으로 이동
    
    
    // 2. 하위 뷰 스크롤 하여 뷰 이동
    // 2.1. 탭바 선택값 반영
    // 2.2. 선택된 탭바 중앙으로 이동
    
    // 1.2 & 2.1
    func setSelected(for index: Int)
    // 1.3 & 2.2
    func moveSelectedTabToCenter()
    
    // 1.1
    var delegate: DealiTabBarViewDelegate_v2? { get }
}
