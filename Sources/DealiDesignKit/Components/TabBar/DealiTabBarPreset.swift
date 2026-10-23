//
//  DealiTabBarPreset.swift
//
//
//  Created by 이창호 on 11/6/24.
//

import UIKit

public enum DealiTabBarPreset {
    /// segment 스타일 형식의 tabbar
    case tabBarSegment01
    /// slider 스타일 형식의 tabbar(기본 텍스트 컬러 - g100, 선택 텍스트 컬러 - primary01)
    case tabBarSlider01
    /// slider 스타일 형식의 tabbar(기본 텍스트 컬러 - g100, 선택 텍스트 컬러 - g100)
    case tabBarSlider02
    /// slider 스타일 형식의 tabbar(chipFilledSmall02 을 사용)
    case tabBarChip01
    /// slider 스타일 형식의 tabbar(chipFilledSmall03 을 사용)
    case tabBarChip02
    /// slider 스타일 형식의 tabbar(imgChipSmall01 을 사용)
    case tabBarImgChip01
    /// 앱이 `DealiTabBarCustomItemView`를 상속한 아이템 뷰를 직접 넣는 tabbar. 간격·여백·높이·하단 구분선은 layout 값을 따른다.
    case tabBarCustom(DealiTabBarCustomLayout)
    
    /// tabber Item Style
    enum DealiTabBarStyle: Equatable {
        case segment
        case slider
        case sliderChip(_ chipStyle: DealiTabBarSliderChipStyle)
        case sliderImageChip(_ chipStyle: DealiTabBarSliderImageChipStyle)
        case custom
    }
    
    /// tab bar chip Item Style
    enum DealiTabBarSliderChipStyle: Equatable {
        case chipFilledSmall02
        case chipFilledSmall03
    }
    
    /// tab bar ImageChip Item Style
    enum DealiTabBarSliderImageChipStyle: Equatable {
        case imgChipSmall01
    }
    
    // MARK: TabBarStyle
    var style: DealiTabBarStyle {
        switch self {
        case .tabBarSegment01:
            return .segment
        case .tabBarChip01:
            return .sliderChip(.chipFilledSmall02)
        case .tabBarChip02:
            return .sliderChip(.chipFilledSmall03)
        case .tabBarImgChip01:
            return .sliderImageChip(.imgChipSmall01)
        case .tabBarCustom:
            return .custom
        default:
            return .slider
        }
    }
    
    // MARK: font
    var font: UIFont {
        return .b1r15
    }
    
    // MARK: SelectedFont
    var selectedFont: UIFont {
        return .b1sb15
    }
    
    // MARK: TextColor - 선택되지 않은 item text Color
    var textColor: UIColor {
        switch self {
        case .tabBarSegment01:
            return .g70
        default:
            return .g100
        }
    }
    
    // MARK: SelectedTextColor - 선택된 item text color
    var selectedTextColor: UIColor {
        switch self {
        case .tabBarSegment01, .tabBarSlider02:
            return .g100
        case .tabBarSlider01:
            return .primary01
        case .tabBarChip01, .tabBarChip02, .tabBarImgChip01:
            return .primary04
        case .tabBarCustom:
            return .g100
        }
    }
    
    // MARK: bottomDividerColor - bottom Divider Color
    var bottomDividerColor: UIColor {
        switch self {
        case .tabBarChip01, .tabBarImgChip01:
            return .clear
        case .tabBarChip02:
            return .g20
        case .tabBarCustom(let layout):
            return layout.bottomDividerColor
        default:
            return .g30
        }
    }
    
    // MARK: itemSpacing - item간의 거리값
    var itemSpacing: CGFloat {
        switch self {
        case .tabBarChip01, .tabBarChip02, .tabBarImgChip01:
            return 8.0
        case .tabBarCustom(let layout):
            return layout.itemSpacing
        default:
            return 0.0
        }
    }
    
    // MARK: itemHorizontalPadding - item Text 양쪽 padding
    var itemHorizontalPadding: CGFloat {
        switch self {
        case .tabBarSlider01, .tabBarSlider02:
            return 12.0
        default:
            return 0.0
        }
    }
    
    // MARK: tabBarHorizontalMargin - TabbarView content영역 양쪽 margin
    var tabBarHorizontalMargin: CGFloat {
        switch self {
        case .tabBarSegment01, .tabBarChip01, .tabBarChip02, .tabBarImgChip01:
            return 16.0
        case .tabBarCustom(let layout):
            return layout.horizontalMargin
        default:
            return 4.0
        }
    }
    
    // MARK: TabBarContentHeight - TabBarView의 내부 content 높이
    var tabBarContentHeight: CGFloat {
        switch self {
        case .tabBarChip01, .tabBarChip02, .tabBarImgChip01:
            return 56.0
        case .tabBarCustom(let layout):
            return layout.contentHeight
        default:
            return 44.0
        }
    }
    
    // MARK: TabBarViewHeight - TabBarView 높이
    var tabBarViewHeight: CGFloat {
        switch self {
        case .tabBarChip01, .tabBarChip02, .tabBarImgChip01:
            return 56.0
        case .tabBarCustom(let layout):
            return layout.contentHeight
        default:
            return 44.0
        }
    }
}

/**
 설명: tabBarCustom의 레이아웃 값. 아이템 뷰 모양은 앱이 정하고 탭바는 이 값으로 간격·여백·높이만 잡는다.

 기본값은 chip 탭바(`tabBarChip01`)와 같은 간격 8 / 여백 16 / 높이 56이다. 필요한 값만 바꿔서 넘긴다.
 ```swift
 DealiTabBarCustomLayout(itemSpacing: 4.0, contentHeight: 56.0)
 ```
 */
public struct DealiTabBarCustomLayout: Equatable {
    /// 아이템 사이 간격. 기본 8
    public var itemSpacing: CGFloat
    /// 탭바 양쪽 여백. 기본 16
    public var horizontalMargin: CGFloat
    /// 탭바 높이. 아이템 뷰는 이 높이 안에서 세로 가운데 정렬된다. 기본 56
    public var contentHeight: CGFloat
    /// 하단 구분선 색. 기본 clear
    public var bottomDividerColor: UIColor
    
    public init(itemSpacing: CGFloat = 8.0,
                horizontalMargin: CGFloat = 16.0,
                contentHeight: CGFloat = 56.0,
                bottomDividerColor: UIColor = .clear) {
        self.itemSpacing = itemSpacing
        self.horizontalMargin = horizontalMargin
        self.contentHeight = contentHeight
        self.bottomDividerColor = bottomDividerColor
    }
}
