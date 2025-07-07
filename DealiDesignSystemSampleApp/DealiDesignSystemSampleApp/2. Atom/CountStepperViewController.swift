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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CountStepper Component"
        self.view.backgroundColor = .primary04
        
        self.countStepper.changeCountAction.asSignal().emit(with: self, onNext: { owner, selectCount in
            print("count = \(selectCount)")
        }).disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        
        self.view.addSubview(self.countStepper)
        self.countStepper.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
