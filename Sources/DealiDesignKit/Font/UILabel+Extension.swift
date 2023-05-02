//
//  UILabel+Extension.swift
//
//
//  Created by 윤조현 on 2023/04/12.
//

import UIKit

public extension UILabel {
    var dealiText: String? {
        get {
            return self.text
        }
        set(newValue) {
            
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = self.font.dealiLineHeight ?? 0.0
            style.minimumLineHeight = self.font.dealiLineHeight ?? 0.0
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: ((self.font.dealiLineHeight ?? 0.0) - self.font.lineHeight) / 4,
            ]
            
            let attrString = NSAttributedString(string: newValue ?? "",
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
