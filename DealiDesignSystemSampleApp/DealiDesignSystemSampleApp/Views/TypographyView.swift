//
//  TypographyView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit

import DealiDesignKit

final class TypographyView: UIView {
//    private let flexContainer = UIView()
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//    
//    var fontViewArray: [FontView] = []
//    
//    init() {
//        super.init(frame: .zero)
//        
//        self.backgroundColor = .white
//        self.addSubview(flexContainer)
//        
//        self.flexContainer.flex
//            .define {
//                $0.addItem(self.scrollView)
//            }
//        
//        self.scrollView.flex.addItem(self.contentView)
//        
//        self.contentView.flex
//            .padding(12.0)
//            .backgroundColor(.lightGray.withAlphaComponent(0.4))
//            .define { flex in
//                DealiFont.allCases.forEach {
//                    flex.addItem(self.makeFontView(font: $0)).marginBottom(10.0)
//                }
//            }
//    }
//    
//    private func makeFontView(font: DealiFont) -> UIView {
//        let fontView = FontView(font: font)
//        self.fontViewArray.append(fontView)
//        return fontView
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

final class FontView: UIView {
    private let flexContainer = UIView()
    
    let button = UIButton()
    let label = UILabel()
    
    var isOpened = false
    
//    init(font: DealiFont) {
//        super.init(frame: .zero)
//        
//        self.addSubview(self.flexContainer)
//        self.flexContainer.flex
//            .direction(.column)
//            .padding(10.0)
//            .backgroundColor(.white)
//            .define {
//                $0.addItem(button.then {
//                    $0.titleLabel?.font = font.font
//                    $0.contentHorizontalAlignment = .left
//                    $0.setTitle(font.fontTitle, for: .normal)
//                    $0.setTitleColor(.black, for: .normal)
//                })
//                
//                $0.addItem(label.then {
//                    $0.font = font.font
//                    $0.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam non scelerisque nulla. Sed eu vulputate nibh, in posuere diam. Nullam."
//                    $0.textColor = .black
//                    $0.numberOfLines = 0
//                })
//                .height(0)
//            }
//    }
    
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.flexContainer.pin.all()
//        self.flexContainer.flex.layout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
