//
//  TypographyView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit

import DealiDesignKit

final class TypographyView: UIView {
    private let flexContainer = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.addSubview(flexContainer)
        
        self.flexContainer.flex
            .define {
                $0.addItem(self.scrollView)
            }
        
        self.scrollView.flex.addItem(self.contentView)
        
        self.contentView.flex
            .margin(12.0)
            .define { flex in
                DealiFont.allCases.forEach {
                    flex.addItem(self.makeFontView(font: $0)).marginTop(10.0)
                }
            }
    }
    
    private func makeFontView(font: DealiFont) -> UIView {
        let view = UIView()
        view.flex.define {
            
            $0.addItem(UILabel().then {
                $0.font = .b1Bold
                $0.text = font.fontTitle
            })
            
            $0.addItem(UILabel().then {
                $0.font = font.font
                $0.text = "HELLO WORLD hello world 안녕하세요"
                $0.numberOfLines = 0
            })
        }
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexContainer.pin.all(pin.safeArea)
        self.flexContainer.flex.layout()
        
        self.scrollView.pin.all()
        self.scrollView.contentSize = self.contentView.frame.size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
