//
//  DealiTabBarItemTextStyleCellUIModel.swift
//
//
//  Created by 이창호 on 11/4/24.
//

import UIKit

public struct DealiTabBarItemTextStyleCellUIModel {
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
    var textColor: UIColor = .g100
    /// 기본 텍스트 폰트
    var font: UIFont = .b2r14
    /// 아이콘 URL
    var iconURL: URL?
    /// 아이콘 이미지
    var iconImage: UIImage?
    /// 아이콘 사이즈
    var iconSize: CGSize?

    var hasIcon: Bool {
        self.iconURL != nil || self.iconImage != nil
    }

    private var preset: DealiTabBarPreset?

    static func make(preset: DealiTabBarPreset, tabbarItem: DealiTabBarItemProtocol) -> DealiTabBarItemTextStyleCellUIModel {
        var uiModel = DealiTabBarItemTextStyleCellUIModel()
        uiModel.preset = preset
        uiModel.title = tabbarItem.title
        uiModel.textColor = preset.textColor
        uiModel.font = preset.font
        uiModel.iconURL = tabbarItem.icon?.url
        uiModel.iconImage = tabbarItem.icon?.image
        uiModel.iconSize = tabbarItem.icon?.size
        uiModel.shouldExposeNewBadge = tabbarItem.showsBadge
        return uiModel
    }
}
