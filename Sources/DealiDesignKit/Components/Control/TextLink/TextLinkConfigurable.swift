//
//  TextLinkConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import UIKit

final class TextLinkConfig: ControlConfigurable {
    
    var status: DealiButtonStatus = .normal {
        didSet {
            self.updateAppearance()
        }
    }
    
    enum Constants {
        static let iconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)
        static let interItemSpacing: CGFloat = 4.0
        
    }
    
    var color: TextLinkColor = TextLinkColor(textColor: .primary01, backgroundColor: .clear)
    
    var style: TextLinkStyle
    var size: TextLinkSize
    
    
    init(size: TextLinkSize, style: TextLinkStyle) {
        self.size = size
        self.style = style
    }
    
    func updateAppearance() {
        let color = self.style.colorProvider.getColor(for: self.status)
        self.color = color
    }
    
}

struct TextLinkStyle: ControlStyleProtocol {
    var underLineWhenSelected: Bool
    var colorProvider: TextLinkColors
}

struct TextLinkSize: ControlSizeProtocol {
    var height: CGFloat
    var font: UIFont
    
}

struct TextLinkColors: ControlColorPrivider {
    
    var normal: TextLinkColor
    var disabled: TextLinkColor
    
    func getColor(for status: DealiButtonStatus) -> TextLinkColor {
        switch status {
        case .normal: return normal
        case .highlighted: return normal
        case .disabled: return disabled
        }
    }
    
}

struct TextLinkColor {
    var textColor: UIColor
    var backgroundColor: UIColor
}
