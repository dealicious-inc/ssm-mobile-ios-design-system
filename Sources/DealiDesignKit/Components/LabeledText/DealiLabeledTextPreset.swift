//
//  DealiDescriptionItemModel.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiLabeledTextPreset {
    
    case labeledTextBullet01
    case labeledTextBullet02
    case labeledTextNumber01
    case labeledTextNumber02
    case labeledTextIcon01
    case labeledTextIcon02
    /// 디자인시스템에서 정의되어 있지 않는 스타일 적용시 사용
    case labeledTextCustom
    
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
        case .labeledTextBullet02, .labeledTextNumber02, .labeledTextIcon02:
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
    var message: String?
    var attributedMessage: NSMutableAttributedString?
    var iconName: String?
    var numberString: String?
    
    public init(message: String? = nil, attributedMessage: NSMutableAttributedString? = nil, iconName: String? = nil, numberString: String? = nil) {
        self.message = message
        self.attributedMessage = attributedMessage
        self.iconName = iconName
        self.numberString = numberString
    }
}
