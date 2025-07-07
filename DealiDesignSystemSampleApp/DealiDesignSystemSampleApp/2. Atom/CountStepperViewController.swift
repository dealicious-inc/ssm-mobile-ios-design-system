//
//  CountStepperViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 7/7/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class CountStepperViewController: UIViewController {

    private let countStepper = DealiCountStepper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CountStepper Component"
        self.view.backgroundColor = .primary04
        
        self.countStepper.changeCountActionHandler = { count in
            print("count = \(count)")
        }
    }
    
    override func loadView() {
        super.loadView()
        
        
        self.view.addSubview(self.countStepper)
        self.countStepper.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
