//
//  MainView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit
import DealiDesignKit

final class MainView: UIView {
    private let flexContainer = UIView()
    
    let fontButton = UIButton()
    let colorButton = UIButton()
    let uiElementButton = UIButton()
    
//    init() {
//        super.init(frame: .zero)
//        
//        self.addSubview(self.flexContainer)
//        self.backgroundColor = .white
//        
//        self.setAttributes()
//        
//        self.flexContainer.flex
//            .backgroundColor(.white)
//            .direction(.column)
//            .paddingHorizontal(20.0)
//            .define {
//                $0.addItem(self.fontButton).height(50.0).backgroundColor(DealiColor.secondary01).cornerRadius(8.0).marginTop(20.0)
//                $0.addItem(self.colorButton).height(50.0).backgroundColor(DealiColor.secondary01).cornerRadius(8.0).marginTop(20.0)
//                $0.addItem(self.uiElementButton).height(50.0).backgroundColor(DealiColor.secondary01).cornerRadius(8.0).marginTop(20.0)
//            }
//    }
//    
//    private func setAttributes() {
//        self.fontButton.do {
//            $0.titleLabel?.font = .b1Bold
//            $0.setTitle("1. Typography", for: .normal)
//        }
//        
//        self.colorButton.do {
//            $0.titleLabel?.font = .b1Bold
//            $0.setTitle("2. Color", for: .normal)
//        }
//        
//        self.uiElementButton.do {
//            $0.titleLabel?.font = .b1Bold
//            $0.setTitle("10. UI Elements", for: .normal)
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.flexContainer.pin.all(pin.safeArea)
//        self.flexContainer.flex.layout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
