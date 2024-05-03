//
//  TextAreaViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2024/05/03.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxCocoa
import RxKeyboard

final class TextAreaViewController: UIViewController {
    
    private let contentScrollView = UIScrollView()
    private let textArea = DealiTextArea()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = DealiColor.primary04
        
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        self.contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.textArea)
        self.textArea.then {
            $0.title = "Label"
            $0.isMandatory = true
            $0.placeholder = "placeholder"
            $0.keyboardCloseButtonString = "닫기"

        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}
