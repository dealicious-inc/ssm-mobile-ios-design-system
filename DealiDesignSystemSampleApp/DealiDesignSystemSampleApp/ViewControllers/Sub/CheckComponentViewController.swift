//
//  CheckComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 4/24/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

class CheckComponentViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabBar"
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        
    
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let checkcircleWithTextButton01 = DealiCheckcircleWithText()
        contentStackView.addArrangedSubview(checkcircleWithTextButton01)
        checkcircleWithTextButton01.then{
            $0.text = "checkcircleWithTextButton01"
            $0.isEnabled = true
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        let checkcircleWithTextButton02 = DealiCheckcircleWithText()
        contentStackView.addArrangedSubview(checkcircleWithTextButton02)
        checkcircleWithTextButton02.then{
            $0.text = "checkcircleWithTextButton02"
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        let checkcircleWithTextButton03 = DealiCheckcircleWithText()
        contentStackView.addArrangedSubview(checkcircleWithTextButton03)
        checkcircleWithTextButton03.then{
            $0.text = "checkcircleWithTextButton03"
            $0.isAd = true
            $0.isEnabled = true
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        checkcircleWithTextButton01.valueChanged.asSignal().emit(with: self) { owner, isSelected in
            print("checkcircleWithTextButton01 = \(isSelected)")
        }.disposed(by: self.disposeBag)
        
        checkcircleWithTextButton03.valueChanged.asSignal().emit(with: self) { owner, isSelected in
            print("checkcircleWithTextButton03 = \(isSelected)")
        }.disposed(by: self.disposeBag)
    }
}
