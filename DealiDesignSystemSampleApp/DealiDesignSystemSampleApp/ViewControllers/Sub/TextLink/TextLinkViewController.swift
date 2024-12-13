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
    
    private let textLinkArray: [TextLink] = [
        DealiControl.textLinkLarge01(),
        DealiControl.textLinkLineLarge01(),
        DealiControl.textLinkLarge02(),
        DealiControl.textLinkLineLarge02(),
        DealiControl.textLinkLarge03(),
        DealiControl.textLinkLineLarge03(),
        DealiControl.textLinkLarge04(),
        DealiControl.textLinkLineLarge04(),
        DealiControl.textLinkLarge05(),
        DealiControl.textLinkLineLarge05(),
        DealiControl.textLinkLarge06(),
        DealiControl.textLinkLineLarge06(),
        DealiControl.textLinkLarge07(),
        DealiControl.textLinkLineLarge07(),
        DealiControl.textLinkMedium01(),
        DealiControl.textLinkLineSmall01(),

        
    ]
    
    override func loadView() {
        self.view = .init()
        
        self.setUI()
    }
    
}

private extension TextLinkViewController {
    func setUI() {
        self.view.backgroundColor = .w50
        
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
        
        for textLink in self.textLinkArray {
            self.stackView.addArrangedSubview(textLink)
            textLink.do {
                $0.title = "textlink"
                $0.leftImage = .init(dealiIconName: "ic_check")
                $0.rightImage = .init(dealiIconName: "ic_x")
            }
        }
        
    }
}
