//
//  ColorView.swift
//  DealiDesignSystemSampleApp
//
//  Created by Nam Jun Lee on 2023/05/19.
//

import UIKit
import DealiDesignKit

final class ColorView: UIView {
    private let flexContainer = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
//    init() {
//        super.init(frame: .zero)
//        
//        self.backgroundColor = .white
//        
//        self.addSubview(self.flexContainer)
//        self.flexContainer.flex.addItem(self.scrollView)
//        
//        self.scrollView.flex.addItem(self.contentView)
//        self.contentView.flex
//            .direction(.row)
//            .wrap(.wrap)
//            .justifyContent(.center)
//            .define { flex in
//                TempDealiColor.allCases.forEach {
//                    flex.addItem(ColorCardView(color: $0)).width(40%).margin(10)
//                }
//            }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.flexContainer.pin.all(pin.safeArea)
//        self.flexContainer.flex.layout()
//        
//        self.scrollView.pin.all()
//        self.scrollView.contentSize = self.contentView.frame.size
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

final class ColorCardView: UIView {
    private let flexContainer = UIView()
    
    let colorView = UIView()
    let titleLabel = UILabel()
    
//    init(color: TempDealiColor) {
//        super.init(frame: .zero)
//        
//        self.addSubview(self.flexContainer)
//        self.flexContainer.flex
//            .direction(.column)
//            .padding(15.0)
//            .cornerRadius(6.0)
//            .backgroundColor(TempDealiColor.gray10.color)
//            .define {
//                $0.addItem(self.colorView).aspectRatio(200.0 / 150.0).backgroundColor(color.color).cornerRadius(6.0).height(75%)
//                $0.addItem(self.titleLabel.then {
//                    $0.font = .b1Bold
//                    $0.textAlignment = .left
//                    $0.text = color.rawValue
//                })
//                .marginTop(15.0)
//            }
//            .aspectRatio(1)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
