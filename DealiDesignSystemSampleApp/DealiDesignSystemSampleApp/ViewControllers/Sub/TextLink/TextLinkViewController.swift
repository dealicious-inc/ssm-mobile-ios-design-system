//
//  TextLinkViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by JohyeonYoon on 12/9/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class TextLinkViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let textLink = TextLink()
    
    
    override func loadView() {
        self.view = .init()
        
        self.setUI()
    }
    
}

private extension TextLinkViewController {
    func setUI() {
        self.view.backgroundColor = .systemGray2
        
        let scrollView = UIScrollView()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
            $0.alignment = .center
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
        
        self.stackView.addArrangedSubview(self.textLink) 
        self.textLink.then {
//            $0.status = .disabled
            $0.title = "김수한무거북이"
            $0.leftImage = .init(dealiIconName: "ic_check")
            $0.rightImage = .init(dealiIconName: "ic_x")

        }.snp.makeConstraints {
            $0.width.equalTo(140.0)
            $0.height.equalTo(20.0)
        }
        
        
    }
}
