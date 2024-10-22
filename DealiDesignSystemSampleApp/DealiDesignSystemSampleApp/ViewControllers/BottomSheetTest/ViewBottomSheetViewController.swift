//
//  ViewBottomSheetViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/16/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

class ViewBottomSheetViewController: DealiBottomSheetBaseViewController {

    let scrollContentStackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        
        self.titleType = .titleCloseButton(title: "View")
        self.closeBottomSheetOnOutsideTouch = true
        
        
        self.containerView.addSubview(self.scrollContentStackView)
        self.scrollContentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 8.0
            $0.backgroundColor = .g20
        }.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        for i in 0..<8 {
            let textLabel = UILabel()
            self.scrollContentStackView.addArrangedSubview(textLabel)
            textLabel.then {
                $0.text = "textLabel _ \(i)"
                $0.font = .sh1r20
                $0.textColor = .g100
                $0.backgroundColor = .primary04
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                $0.height.equalTo(50.0)
            }
        }
    }
    
    override func updateContainerViewHeight() {
        self.scrollContentStackView.layoutIfNeeded()
        var containerHeight: CGFloat = 0.0
        let bottomSheetMaxHeight = (UIScreen.main.bounds.size.height * self.heightRatio)
        let titleContentHeight = (self.titleType == .hidden ? 0.0 : self.titleContentViewHeight)
        
        if self.fixedHeight > 0.0 {
            containerHeight = self.fixedHeight - titleContentHeight
        } else {
            
            let width: CGFloat = UIScreen.main.bounds.size.width - 36.0
            let height: CGFloat = 0.0
            let targetSize = CGSize(width: width, height: height)
            
            var size = self.scrollContentStackView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            size.width = width
            
            containerHeight = size.height
            
            if (containerHeight + titleContentHeight) > bottomSheetMaxHeight {
                containerHeight = bottomSheetMaxHeight - titleContentHeight
            }
        }
        
        self.containerView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(containerHeight)
        }
    }

}
