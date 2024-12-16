//
//  DealiTabBarItemChipStyleCellUIModel.swift
//
//
//  Created by 이창호 on 11/18/24.
//

import UIKit

public struct DealiTabBarItemChipStyleCellUIModel {
    
    var itemChip: ClickableComponentChip?
    
    static func make(chipStyle: DealiTabBarPreset.DealiTabBarSliderChipStyle, tabbarItem: DealiTabBarItemProtocol) -> DealiTabBarItemChipStyleCellUIModel {
        var uiModel = DealiTabBarItemChipStyleCellUIModel()
        switch chipStyle {
        case .chipFilledSmall02:
            uiModel.itemChip = DealiControl.chipFilledSmall02()
        case .chipFilledSmall03:
            uiModel.itemChip = DealiControl.chipFilledSmall03()
        }
        
        uiModel.itemChip?.do {
            $0.title = tabbarItem.title
            $0.isUserInteractionEnabled = false
        }
        
        return uiModel
    }
}
