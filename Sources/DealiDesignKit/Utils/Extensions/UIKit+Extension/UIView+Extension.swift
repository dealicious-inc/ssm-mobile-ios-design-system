//
//  UIView+Extension.swift
//
//
//  Created by 조서현 on 11/10/23.
//

import UIKit
import SwiftUI

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
    
    func toSwiftUIView() -> some View {
        return UIViewWrapper(uiView: self)
    }
}

public extension UIView {
    @discardableResult
    func setSystemGradient(_ gradient: GradientConfigurable) -> CAGradientLayer {
        let gradientLayer = self.systemGradient(gradient)
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    func systemGradient(_ gradient: GradientConfigurable) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.colors.map { $0.cgColor }
        gradientLayer.locations = gradient.location
        gradientLayer.startPoint = gradient.startPoint
        gradientLayer.endPoint = gradient.endPoint
        gradientLayer.frame = self.bounds
        
        return gradientLayer
    }
}

struct UIViewWrapper: UIViewRepresentable {
    let uiView: UIView

    func makeUIView(context: Context) -> UIView {
        return uiView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 필요하면 업데이트 로직 추가
    }
}
