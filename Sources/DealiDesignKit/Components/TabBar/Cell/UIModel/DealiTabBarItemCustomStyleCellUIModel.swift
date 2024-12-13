//
//  DealiTabBarItemCustomStyleCellUIModel.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 12/13/24.
//

import UIKit

public struct DealiTabBarItemCustomStyleCellUIModel {
    
    var customView: UIView?
    
    static func make(tabbarItem: DealiTabBarCustomItem) -> DealiTabBarItemCustomStyleCellUIModel {
        var uiModel = DealiTabBarItemCustomStyleCellUIModel()
        uiModel.customView = tabbarItem.customView
        
        return uiModel
    }
}
