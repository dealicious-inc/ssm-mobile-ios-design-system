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
        
        let btnFilledLargeTest01 = DealiControl.btnFilledLargeTest01()
        self.stackView.addArrangedSubview(btnFilledLargeTest01)
        btnFilledLargeTest01.then {
            $0.leftImage = ClickableImage(UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.title = "btnFilledLargeTest01\nbtnFilledLargeTest02\nbtnFilledLargeTest03"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let btnFilledRoundLargeTest01 = DealiControl.btnFilledRoundLargeTest01()
        self.stackView.addArrangedSubview(btnFilledRoundLargeTest01)
        btnFilledRoundLargeTest01.then {
            $0.leftImage = ClickableImage(UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 20.0, height: 20.0)))
            $0.title = "btnFilledRoundLargeTest01"
            $0.rightImage = ClickableImage(UIImage.dealiIcon(named: "ic_file_copy")?.resize(CGSize(width: 20.0, height: 20.0)))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
