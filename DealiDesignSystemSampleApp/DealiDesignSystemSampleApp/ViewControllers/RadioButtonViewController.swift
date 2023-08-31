//
//  RadioButtonViewController.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit
import DealiDesignKit

    
final class RadioButtonViewController: UIViewController {
    
    let radioButton = DealiRadioButton()
    let disabledRadioButton = DealiRadioButton()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
      
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        contentView.addSubview(self.radioButton)
        self.radioButton.then {
            $0.addTarget(self, action: #selector(radioButtonValueChanged), for: .valueChanged)
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentView.addSubview(self.disabledRadioButton)
        self.disabledRadioButton.then {
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.radioButton.snp.bottom).offset(20.0)
        }
    }
    
    @objc func radioButtonValueChanged() {
        if radioButton.isSelected {
            print("라디오 버튼 선택")
        } else {
            print("라디오 버튼 선택 해제")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
