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
    let enableSwitch = DealiSwitch()
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(enableSwitch)
        enableSwitch.style = .iosSystem
        enableSwitch.addTarget(self, action: #selector(systemSwitchValueChanged), for: .valueChanged)
        enableSwitch.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let disableOffSwitch = DealiSwitch()
        self.view.addSubview(disableOffSwitch)
        disableOffSwitch.then {
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(enableSwitch.snp.bottom).offset(20.0)
        }
        
        
        let disableOnSwitch = DealiSwitch(style: .andriodSystem)
        self.view.addSubview(disableOnSwitch)
        disableOnSwitch.then {
            $0.setOn(false, animated: true)
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(disableOffSwitch.snp.bottom).offset(20.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc func systemSwitchValueChanged() {
        print(self.enableSwitch.isOn)
    }
}



