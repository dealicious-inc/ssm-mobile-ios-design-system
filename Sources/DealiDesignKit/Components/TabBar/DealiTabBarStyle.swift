//
//  File.swift
//  
//
//  Created by 이창호 on 4/9/24.
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
    /// slider 스타일 형식의 tabbar(기본 텍스트 컬러 - g100, 선택 텍스트 컬러 - primary01) tabBar02와 스탸일은 동일하지만 tabbar 높이 값이 작음
    case tabBarSlider03
    
    /// tabber Item Style
    enum DealiTabBarStyle: Equatable {
        case segment
        case sliderButton
        case sliderChip(_ chipStyle: DealiTabBarSliderChipStyle)
    }
    
    /// tabber Item Style
    enum DealiTabBarSliderChipStyle: Equatable {
        case chipFilledSmall02
    }
    
    // MARK: TabBarStyle
    var style: DealiTabBarStyle {
        switch self {
        case .tabBarSegment01:
            return .segment
        case .tabBarChip01:
            return .sliderChip(.chipFilledSmall02)
        default:
            return .sliderButton
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
        case .tabBarSlider01, .tabBarSlider03:
            return .primary01
        case .tabBarChip01:
            return .primary04
        }
    }
    
    // MARK: ContentSpacing - item간의 거리값
    var contentSpacing: CGFloat {
        switch self {
        case .tabBarChip01:
            return 8.0
        default:
            return 0.0
        }
    }
    
    // MARK: ContentButtonPadding - item Text 양쪽 padding
    var contentButtonPadding: CGFloat {
        switch self {
        case .tabBarSlider01, .tabBarSlider02, .tabBarSlider03:
            return 12.0
        default:
            return 0.0
        }
    }
    
    // MARK: TabbarMargin - TabbarView content영역 양쪽 margin
    var tabBarMargin: CGFloat {
        switch self {
        case .tabBarSegment01, .tabBarChip01:
            return 16.0
        default:
            return 4.0
        }
    }
    
    // MARK: TabBerContentHeight - TabBarView의 내부 content 높이
    var tabBerContentHeight: CGFloat {
        switch self {
        case .tabBarChip01:
            return 56.0
        default:
            return 44.0
        }
    }
    
    // MARK: TabBarViewHeight - TabBarView 높이
    var tabBarViewHeight: CGFloat {
        switch self {
        case .tabBarChip01:
            return 56.0
        case .tabBarSlider03:
            return 36.0
        default:
            return 44.0
        }
    }
}
