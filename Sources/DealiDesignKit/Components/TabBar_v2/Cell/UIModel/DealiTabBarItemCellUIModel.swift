//
//  File.swift
//  
//
//  Created by 이창호 on 11/4/24.
//

import UIKit

public struct DealiTabBarItemCellUIModel {
    /// 뉴 뱃지 노출 유무
    var shouldExposeNewBadge: Bool = false
    /// TabBar Item 선택 유무
    var isSelected: Bool = false {
        didSet {
            if let preset = self.preset {
                self.font = self.isSelected ? preset.selectedFont : preset.font
                self.textColor = self.isSelected ? preset.selectedTextColor : preset.textColor
            }
        }
    }
    /// 버튼 타이틀
    var title: String?
    /// 기본 텍스트 컬러
    var textColor: UIColor = DealiColor.g100
    /// 기본 텍스트 폰트
    var font: UIFont = .b2r14
    /// 아이콘 URL
    var iconURL: URL?
    /// 아이콘 사이즈
    var iconSize: CGSize?
    
    private var preset: DealiTabBarPreset_V2?
    
    static func make(preset: DealiTabBarPreset_V2, tabbarItem: DealiTabBarItem) -> DealiTabBarItemCellUIModel {
        var uiModel = DealiTabBarItemCellUIModel()
        uiModel.preset = preset
        uiModel.title = tabbarItem.title
        uiModel.textColor = preset.textColor
        uiModel.font = preset.font
        uiModel.iconURL = tabbarItem.icon?.url
        uiModel.iconSize = tabbarItem.icon?.size
        uiModel.shouldExposeNewBadge = tabbarItem.showsBadge
        return uiModel
    }
}
