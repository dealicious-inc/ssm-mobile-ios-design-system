//
//  DealiDescriptionItemModel.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiLabeledTextPreset {
    
    /**
     예시
        - 타이틀영역(optional)
        - ● 문구영역
     */
    case labeledTextBullet01
    case labeledTextBullet02
    
    /**
     예시
        - 타이틀영역(optional)
        - 1. 문구영역
     */
    case labeledTextNumber01
    case labeledTextNumber02
    /**
     예시
        - 타이틀영역(optional)
        - (아이콘) 문구영역
     */
    case labeledTextIcon01
    case labeledTextIcon02
    
    /// 디자인시스템에서 정의되어 있지 않는 스타일 적용시 사용
    /**
    예시
       - 타이틀영역(optional)
       - [customView] 문구영역
       - ● [customView] 문구영역
       - 1. [customView] 문구영역
       - (아이콘) [customView] 문구영역
    */
    case labeledTextCustom01
    case labeledTextCustom02
    
    enum DealiLabeledTextIStyle: Equatable {
        case bullet
        case number
        case icon
        case custom
    }
    
    var style: DealiLabeledTextIStyle {
        switch self {
        case .labeledTextBullet01, .labeledTextBullet02:
            return .bullet
        case .labeledTextNumber01, .labeledTextNumber02:
            return .number
        case .labeledTextIcon01, .labeledTextIcon02:
            return .icon
        default:
            return .custom
        }
    }
    
    var font: UIFont {
        return .b3r13
    }
    
    var textColor: UIColor {
        switch self {
        case .labeledTextBullet02, .labeledTextNumber02, .labeledTextIcon02, .labeledTextCustom02:
            return UIColor.g100
        default:
            return UIColor.g80
        }
        
    }
    
    // MARK: itemSpacing - item간의 거리값
    var itemSpacing: CGFloat {
        switch self {
        case .labeledTextNumber01, .labeledTextNumber02:
            return 4.0
        default:
            return 8.0
        }
    }
}

public struct DealiLabeledTextModel {
    public var message: String?
    public var attributedMessage: NSMutableAttributedString?
    public var iconName: String?
    public var number: Int?
    public var labeledCustomView: UIView?
    /// 문구영역에서 `applyLinkStyle(for:)`로 지정한 링크 텍스트를 탭했을때 호출된다. 탭한 링크 텍스트가 전달된다
    /// 핸들러에서 화면을 캡쳐할 경우 순환참조가 생길 수 있으므로 `[weak self]`를 사용한다
    public var textLinkHandler: ((String) -> Void)?
    
    public init(message: String? = nil, attributedMessage: NSMutableAttributedString? = nil, iconName: String? = nil, number: Int = 0, labeledCustomView: UIView? = nil, textLinkHandler: ((String) -> Void)? = nil) {
        self.message = message
        self.attributedMessage = attributedMessage
        self.iconName = iconName
        self.number = number
        self.labeledCustomView = labeledCustomView
        self.textLinkHandler = textLinkHandler
    }
}
