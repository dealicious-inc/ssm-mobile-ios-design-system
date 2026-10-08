//
//  DealiTabBarItemCustomStyleCellUIModel.swift
//
//
//  Created by 이창호 on 10/8/26.
//

import UIKit

/**
 설명: tabBarCustom 아이템 셀에 넣을 커스텀 뷰를 들고 있는 UIModel
 */
public struct DealiTabBarItemCustomStyleCellUIModel {
    
    var itemView: DealiTabBarCustomItemView?
    
    static func make(tabbarItem: DealiTabBarItemProtocol) -> DealiTabBarItemCustomStyleCellUIModel {
        var uiModel = DealiTabBarItemCustomStyleCellUIModel()
        uiModel.itemView = tabbarItem.customView
        // 탭 선택은 셀이 처리하므로 아이템 뷰가 터치를 가로채지 않게 한다.
        uiModel.itemView?.isUserInteractionEnabled = false
        return uiModel
    }
}
