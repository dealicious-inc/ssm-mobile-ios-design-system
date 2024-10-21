//
//  DealiDescriptionItemModel.swift
//
//
//  Created by Lee Chang Ho on 8/23/24.
//

import UIKit

public enum DealiDescriptionStyle: Equatable {
    case bullet
    case numbering
    case html
    
    var font: UIFont {
        return .b3r13
    }
    
    var textColor: UIColor {
        return DealiColor.g80
    }
}

public struct DealiDescriptionItemModel {
    /// description 스타일
    var style: DealiDescriptionStyle = .bullet
    /// 노출된 설명 String array
    var descriptionStringArray: [String] = []
    /// 설명에 대한 타이틀(옵셔널)
    var title: String? = nil
    
    public init(style: DealiDescriptionStyle, descriptionStringArray: [String], title: String? = nil) {
        self.style = style
        self.descriptionStringArray = descriptionStringArray
        self.title = title
    }

}
