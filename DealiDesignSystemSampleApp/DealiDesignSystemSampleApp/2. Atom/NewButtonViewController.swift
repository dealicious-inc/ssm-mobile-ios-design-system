//
//  NewButtonViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 8/27/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class NewButtonViewController: UIViewController {

    private let stackView = UIStackView()
    
    private let btnFilledLargeTest01 = DealiControl.btnFilledLargeTest01()
    
    private let btnOutlineLargeTest01 = DealiControl.btnOutlineLargeTest01()
    
    private let btnOutlineBgLargeTest01 = DealiControl.btnOutlineBgLargeTest01()
    private let btnOutlineBgRoundSmallTest01 = DealiControl.btnOutlineBgRoundSmallTest01()
    
    override func loadView() {
        super.loadView()
        
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
        
        
        self.stackView.addArrangedSubview(self.btnFilledLargeTest01)
        self.btnFilledLargeTest01.then {
            $0.leftImage = ClickableImage(UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.title = "btnFilledLargeTest01btnFilledLargeTest01btnFilledLargeTest01btnFilledLargeTest01\nbtnFilledLargeTest02\nbtnFilledLargeTest03"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
//            $0.centerX.equalToSuperview()
        }
        
        let btnFilledRoundLargeTest01 = DealiControl.btnFilledRoundLargeTest01()
        self.stackView.addArrangedSubview(btnFilledRoundLargeTest01)
        btnFilledRoundLargeTest01.then {
//            $0.leftImage = ClickableImage(UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.title = "btnFilledLargeTest01"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.addTarget(self, action: #selector(btnFilledRoundLargeTest01Press(_:)), for: .touchUpInside)
        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        
        self.stackView.addArrangedSubview(self.btnOutlineLargeTest01)
        self.btnOutlineLargeTest01.then {
            $0.title = "btnOutlineLargeTest01"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.addTarget(self, action: #selector(btnOutlineLargeTest01Press(_:)), for: .touchUpInside)
        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        
        self.stackView.addArrangedSubview(self.btnOutlineBgLargeTest01)
        self.btnOutlineBgLargeTest01.then {
            $0.title = "btnOutlineBgLargeTest01"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
//            $0.addTarget(self, action: #selector(btnFilledRoundLargeTest01Press(_:)), for: .touchUpInside)
        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.btnOutlineBgRoundSmallTest01)
        self.btnOutlineBgRoundSmallTest01.then {
            $0.title = "btnOutlineBgRoundSmallTest01"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
//            $0.addTarget(self, action: #selector(btnFilledRoundLargeTest01Press(_:)), for: .touchUpInside)
        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func btnFilledRoundLargeTest01Press(_ sender: SystemButton) {
        print("btnFilledRoundLargeTest01Press")
        self.btnFilledLargeTest01.isEnabled.toggle()
    }
    
    @objc func btnOutlineLargeTest01Press(_ sender: SystemButton) {
        print("btnOutlineLargeTest01Press")
        self.btnOutlineLargeTest01.isSelected.toggle()
        
        if self.btnOutlineLargeTest01.isSelected == true {
            self.btnOutlineBgLargeTest01.startIndicator()
            self.btnOutlineBgRoundSmallTest01.startIndicator()
        } else {
            self.btnOutlineBgLargeTest01.stopIndicator()
            self.btnOutlineBgRoundSmallTest01.stopIndicator()
        }
    }
}
