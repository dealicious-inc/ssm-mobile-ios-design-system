//
//  ScrollViewBottomSheetViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/16/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class ScrollViewBottomSheetViewController: DealiBottomSheetBaseViewController {

    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    
    override func loadView() {
        super.loadView()
        
        self.titleType = .titleCloseButton(title: "ScrollView")
        self.closeBottomSheetOnOutsideTouch = true
        
        self.containerView.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        self.scrollView.addSubview(self.scrollContentView)
        self.scrollContentView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let scrollContentStackView = UIStackView()
        self.scrollContentView.addSubview(scrollContentStackView)
        scrollContentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 8.0
            $0.backgroundColor = DealiColor.g20
        }.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        for i in 0..<100 {
            let textLabel = UILabel()
            scrollContentStackView.addArrangedSubview(textLabel)
            textLabel.then {
                $0.text = "textLabel _ \(i)"
                $0.font = .sh1r20
                $0.textColor = DealiColor.g100
                $0.backgroundColor = DealiColor.primary04
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                $0.height.equalTo(50.0)
            }
        }
    }

}
