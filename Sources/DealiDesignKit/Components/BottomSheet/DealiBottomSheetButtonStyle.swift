//
//  DealiBottomSheetButtonStyle.swift
//
//
//  Created by jalynneyoon on 7/28/26.
//

import UIKit
import SwiftUI

/**
 설명: 바텀시트 하단 버튼에 쓸 수 있는 large 버튼 스타일. UIKit/SwiftUI 매핑의 단일 소스다.
 */
public enum EBottomSheetButtonStyle {
    case btnFilledLarge01
    case btnFilledLarge02
    case btnFilledLarge03
    case btnFilledLarge04
    case btnFilledLarge05
    case btnFilledLarge06
    case btnOutlineLarge01
    case btnOutlineLarge02
    case btnOutlineLarge03
    case btnOutlineLarge04
    case btnOutlineLarge05
    case btnOutlineLarge06

    func makeButton() -> ClickableUnitButtonComponent {
        switch self {
        case .btnFilledLarge01:
            return DealiControl.btnFilledLarge01()
        case .btnFilledLarge02:
            return DealiControl.btnFilledLarge02()
        case .btnFilledLarge03:
            return DealiControl.btnFilledLarge03()
        case .btnFilledLarge04:
            return DealiControl.btnFilledLarge04()
        case .btnFilledLarge05:
            return DealiControl.btnFilledLarge05()
        case .btnFilledLarge06:
            return DealiControl.btnFilledLarge06()
        case .btnOutlineLarge01:
            return DealiControl.btnOutlineLarge01()
        case .btnOutlineLarge02:
            return DealiControl.btnOutlineLarge02()
        case .btnOutlineLarge03:
            return DealiControl.btnOutlineLarge03()
        case .btnOutlineLarge04:
            return DealiControl.btnOutlineLarge04()
        case .btnOutlineLarge05:
            return DealiControl.btnOutlineLarge05()
        case .btnOutlineLarge06:
            return DealiControl.btnOutlineLarge06()
        }
    }

    var buttonConfigStyle: ButtonView.ButtonConfigStyle {
        switch self {
        case .btnFilledLarge01:
            return .btnFilledLarge01
        case .btnFilledLarge02:
            return .btnFilledLarge02
        case .btnFilledLarge03:
            return .btnFilledLarge03
        case .btnFilledLarge04:
            return .btnFilledLarge04
        case .btnFilledLarge05:
            return .btnFilledLarge05
        case .btnFilledLarge06:
            return .btnFilledLarge06
        case .btnOutlineLarge01:
            return .btnOutlineLarge01
        case .btnOutlineLarge02:
            return .btnOutlineLarge02
        case .btnOutlineLarge03:
            return .btnOutlineLarge03
        case .btnOutlineLarge04:
            return .btnOutlineLarge04
        case .btnOutlineLarge05:
            return .btnOutlineLarge05
        case .btnOutlineLarge06:
            return .btnOutlineLarge06
        }
    }
}

/**
 설명: 바텀시트 하단 버튼 사용처(테마). confirm / option / cancel 버튼 스타일 한 벌을 묶는다.
 */
public struct EBottomSheetButtonUsage: Equatable {
    /// 확인 버튼 스타일
    public let confirmButtonStyle: EBottomSheetButtonStyle
    /// 용도가 option일 때의 보조 버튼 스타일
    public let optionButtonStyle: EBottomSheetButtonStyle
    /// 용도가 cancel일 때의 보조 버튼 스타일
    public let cancelButtonStyle: EBottomSheetButtonStyle

    public init(confirmButtonStyle: EBottomSheetButtonStyle,
                optionButtonStyle: EBottomSheetButtonStyle,
                cancelButtonStyle: EBottomSheetButtonStyle = .btnOutlineLarge06) {
        self.confirmButtonStyle = confirmButtonStyle
        self.optionButtonStyle = optionButtonStyle
        self.cancelButtonStyle = cancelButtonStyle
    }

    /// 사용처 = Default
    public static let `default` = EBottomSheetButtonUsage(confirmButtonStyle: .btnFilledLarge01,
                                                          optionButtonStyle: .btnOutlineLarge01)
    /// 사용처 = 도매 멤버십
    public static let wholesaleMembership = EBottomSheetButtonUsage(confirmButtonStyle: .btnFilledLarge02,
                                                                    optionButtonStyle: .btnOutlineLarge01)
    /// 사용처 = 소매 멤버십1
    public static let retailMembership01 = EBottomSheetButtonUsage(confirmButtonStyle: .btnFilledLarge04,
                                                                   optionButtonStyle: .btnOutlineLarge03)
    /// 사용처 = 소매 멤버십2
    public static let retailMembership02 = EBottomSheetButtonUsage(confirmButtonStyle: .btnFilledLarge05,
                                                                   optionButtonStyle: .btnOutlineLarge03)

    /// 디자인 가이드에 정의된 사용처 목록
    public static let allUsages: [EBottomSheetButtonUsage] = [.default, .wholesaleMembership, .retailMembership01, .retailMembership02]

    func subButtonStyle(for cancelButtonType: EBottomSheetCancelButtonType?) -> EBottomSheetButtonStyle {
        return (cancelButtonType ?? .option) == .cancel ? self.cancelButtonStyle : self.optionButtonStyle
    }
}

/**
 설명: 바텀시트 하단 버튼 배치 방향
 */
public enum EBottomSheetButtonAxis {
    /// 좌우 배치. 보조 버튼이 왼쪽, 확인 버튼이 오른쪽
    case horizontal
    /// 상하 배치. 확인 버튼이 위, 보조 버튼이 아래
    case vertical
}

/**
 설명: 바텀시트 하단 보조 버튼의 용도
 */
public enum EBottomSheetCancelButtonType {
    /// 사용처 테마에 맞는 outline 버튼
    case option
    /// secondary04 outline 버튼
    case cancel

    @available(*, deprecated, renamed: "option")
    public static var btnOutlineLarge01: Self { .option }

    @available(*, deprecated, renamed: "cancel")
    public static var btnOutlineLarge06: Self { .cancel }
}

/**
 설명: 바텀시트 하단 버튼 영역 노출 타입
 */
public enum EBottomSheetButtonType: Equatable {
    case hidden
    case oneButton(buttonTitle: String?,
                   usage: EBottomSheetButtonUsage = .default)
    case twoButton(confirmTitle: String?,
                   cancelTitle: String?,
                   cancelButtonType: EBottomSheetCancelButtonType? = .option,
                   usage: EBottomSheetButtonUsage = .default,
                   axis: EBottomSheetButtonAxis = .horizontal)
}

extension EBottomSheetButtonType {
    /// 버튼 영역 상하 여백
    private static let verticalInset = 12.0
    /// large 버튼 높이
    private static let buttonHeight = 50.0
    /// 버튼 사이 간격
    static let buttonSpacing = 8.0

    var isHidden: Bool {
        return self == .hidden
    }

    /// safe area를 제외한 버튼 영역 전체 높이
    var contentHeight: CGFloat {
        switch self {
        case .hidden:
            return 0.0
        case .oneButton:
            return Self.verticalInset * 2.0 + Self.buttonHeight
        case .twoButton(_, _, _, _, let axis):
            guard axis == .vertical else {
                return Self.verticalInset * 2.0 + Self.buttonHeight
            }
            return Self.verticalInset * 2.0 + Self.buttonHeight * 2.0 + Self.buttonSpacing
        }
    }

    var usage: EBottomSheetButtonUsage {
        switch self {
        case .hidden:
            return .default
        case .oneButton(_, let usage):
            return usage
        case .twoButton(_, _, _, let usage, _):
            return usage
        }
    }
}
