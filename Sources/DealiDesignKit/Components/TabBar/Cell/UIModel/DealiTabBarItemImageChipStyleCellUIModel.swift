//
//  DealiTabBarItemImageChipStyleCellUIModel.swift
//
//
//  Created by 이창호 on 12/2/24.
//

import UIKit

public struct DealiTabBarItemImageChipStyleCellUIModel {
    
    var itemImageChip: ImageChip?
    
    static func make(imageChipStyle: DealiTabBarPreset.DealiTabBarSliderImageChipStyle, tabbarItem: DealiTabBarItemProtocol, showImageChipSlotWhenSelected: Bool) -> DealiTabBarItemImageChipStyleCellUIModel {
        var uiModel = DealiTabBarItemImageChipStyleCellUIModel()
        switch imageChipStyle {
        case .imgChipSmall01:
            uiModel.itemImageChip = DealiControl.imgChipSmall01()
        }
        
        uiModel.itemImageChip?.do {
            $0.showSlotWhenSelected = showImageChipSlotWhenSelected
            $0.title = tabbarItem.title
            $0.imageURL = tabbarItem.icon?.url
            $0.slotView = tabbarItem.imageChipSlotView
            $0.isUserInteractionEnabled = false
        }
        
        return uiModel
    }
}
