//
//  UIView+Extension.swift
//
//
//  Created by 조서현 on 11/10/23.
//

import UIKit

extension UIView {
    
    /**
     설명: UIView의 radus 및 border 지정을 한번에 할 수 있습니다.
     */
    func setCornerRadius(_ radius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor? = .clear) {
        if let _ = borderColor {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
