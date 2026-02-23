//
//  CountStepperViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/7/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxCocoa

final class CountStepperViewController: UIViewController {

    private let countStepper = DealiCountStepper()
    private let countLabel = UILabel()
    private let disabledCountStepper = DealiCountStepper()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CountStepper Component"
        self.view.backgroundColor = .primary04
        self.countStepper.delay = 500
        self.countStepper.defaultCountWhenEmpty = 22
        self.countStepper.changeCountAction.asSignal().emit(with: self, onNext: { owner, selectCount in
            print("count = \(selectCount)")
            owner.countLabel.text = "현재 선택된 수량: \(selectCount)"
        }).disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.countStepper)
        self.countStepper.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.view.addSubview(self.disabledCountStepper)
        self.disabledCountStepper.then {
            $0.isEnabled = false
            $0.currentCount = 5
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.countStepper.snp.bottom).offset(20)
        }
        
        self.view.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.disabledCountStepper.snp.bottom).offset(20)
        }
    }

}
