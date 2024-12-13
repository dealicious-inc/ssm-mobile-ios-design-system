//
//  TextLinkConfigurable.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import UIKit

final class TextLinkConfig: ControlConfigurable {
    
    var style: TextLinkStyle
    var size: TextLinkSize
    
    var textFont: UIFont
    var textColor: UIColor
    var iconColor: UIColor
    var backgroundColor: UIColor
    
    init(size: TextLinkSize, style: TextLinkStyle) {
        self.size = size
        self.style = style
        
        self.textFont = size.font

        let provider = self.style.colorProvider
        let color = provider.getColor(for: self.status)
        self.textColor = color.textColor
        self.iconColor = color.iconColor
        self.backgroundColor = color.backgroundColor
    }
    
    var status: DealiButtonStatus = .normal {
        didSet {
            self.updateAppearance()
        }
    }

    func updateAppearance() {
        let provider = self.style.colorProvider
        let color = provider.getColor(for: self.status)
        self.textColor = color.textColor
        self.iconColor = color.iconColor
        self.backgroundColor = color.backgroundColor
        
        
    }
    
}

struct TextLinkStyle: ControlStyleProtocol {
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
    var iconColor: UIColor
    var backgroundColor: UIColor
    
    init(textColor: UIColor, iconColor: UIColor, backgroundColor: UIColor) {
        self.textColor = textColor
        self.iconColor = iconColor
        self.backgroundColor = backgroundColor
    }
    
    init(textColor: UIColor, backgroundColor: UIColor) {
        self.textColor = textColor
        self.iconColor = textColor
        self.backgroundColor = backgroundColor
    }
}
