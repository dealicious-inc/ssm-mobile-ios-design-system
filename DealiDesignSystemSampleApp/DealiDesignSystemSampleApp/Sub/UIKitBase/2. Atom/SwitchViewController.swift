//
//  SwitchViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2023/11/09.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class SwitchViewController: UIViewController {

    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .systemBackground
        
        let contentStackView = UIStackView()
        self.view.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let enableOnLargeSwitch = DealiSwitch(size: .large)
        contentStackView.addArrangedSubview(enableOnLargeSwitch)
        enableOnLargeSwitch.do {
            $0.setOn(true, animated: true)
        }
        
        let denableOffLargeSwitch = DealiSwitch(size: .large)
        contentStackView.addArrangedSubview(denableOffLargeSwitch)
        
        let disableOnLargeSwitch = DealiSwitch(size: .large)
        contentStackView.addArrangedSubview(disableOnLargeSwitch)
        disableOnLargeSwitch.do {
            $0.setOn(true, animated: true)
            $0.isEnabled = false
        }
        
        let disableOffLargeSwitch = DealiSwitch(size: .large)
        contentStackView.addArrangedSubview(disableOffLargeSwitch)
        disableOffLargeSwitch.do {
            $0.isEnabled = false
        }
        
        let enableOnSwitch = DealiSwitch()
        contentStackView.addArrangedSubview(enableOnSwitch)
        enableOnSwitch.do {
            $0.setOn(true, animated: true)
        }
        
        let denableOffSwitch = DealiSwitch()
        contentStackView.addArrangedSubview(denableOffSwitch)
        
        let disableOnSwitch = DealiSwitch()
        contentStackView.addArrangedSubview(disableOnSwitch)
        disableOnSwitch.do {
            $0.setOn(true, animated: true)
            $0.isEnabled = false
        }
        
        let disableOffSwitch = DealiSwitch()
        contentStackView.addArrangedSubview(disableOffSwitch)
        disableOffSwitch.do {
            $0.isEnabled = false
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}



