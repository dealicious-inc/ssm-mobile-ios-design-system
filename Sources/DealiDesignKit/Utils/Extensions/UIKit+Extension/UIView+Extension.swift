//
//  UIView+Extension.swift
//
//
//  Created by 조서현 on 11/10/23.
//

import UIKit
import SwiftUI
import Then
import SnapKit

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
    
    /**
     설명: 키보드 inputAccessoryView 배경을 iOS 26 키보드 형태에 맞게 세팅합니다.
     */
    func setKeyboardAccessoryStyle() {
        self.backgroundColor = .g20

        // iOS 26부터 키보드 패널이 상단 모서리를 라운드로 깎아, 각진 accessory view와 만나는
        // 좌우 이음새에 앱 배경이 드러나는 쐐기가 생긴다.
        // 상단 모서리를 키보드와 같은 곡률로 맞추고, 하단으로 넘치는 view를 키보드 뒤에 깔아
        // 그 쐐기까지 같은 배경색으로 채운다.
        guard #available(iOS 26.0, *) else { return }

        // 키보드 패널 상단 모서리 곡률. 시뮬레이터 렌더링을 픽셀 측정해 맞춘 값.
        let keyboardCornerRadius: CGFloat = 26.5

        self.clipsToBounds = false
        self.layer.cornerRadius = keyboardCornerRadius
        self.layer.cornerCurve = .continuous
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        let overflowView = UIView()
        self.addSubview(overflowView)
        overflowView.then {
            $0.backgroundColor = .g20
        }.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(keyboardCornerRadius)
        }
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
