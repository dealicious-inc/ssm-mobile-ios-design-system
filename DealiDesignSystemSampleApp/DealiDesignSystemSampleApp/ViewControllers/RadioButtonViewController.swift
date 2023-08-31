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

    let radioButtonWithText = DealiRadioButtonWithText()
    let disabledRadioButtonWithText = DealiRadioButtonWithText()

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
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(30.0)
        }
        
        contentView.addSubview(self.disabledRadioButton)
        self.disabledRadioButton.then {
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.radioButton.snp.bottom).offset(20.0)
        }
        
        contentView.addSubview(self.radioButtonWithText)
        self.radioButtonWithText.then {
            $0.addTarget(self, action: #selector(radioButtonWithTextValueChanged), for: .valueChanged)
            $0.text = "김수한무거북이와두루미"
            
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.disabledRadioButton.snp.bottom).offset(20.0)
        }
        
        contentView.addSubview(self.disabledRadioButtonWithText)
        self.disabledRadioButtonWithText.then {
            $0.isEnabled = false
            $0.text = "김수한무거북이와두루미"

        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.radioButtonWithText.snp.bottom).offset(20.0)
        }
        
    }
    
    @objc func radioButtonValueChanged() {
        if self.radioButton.isSelected {
            print("라디오 버튼 선택")
        } else {
            print("라디오 버튼 선택 해제")
        }
    }
    
    @objc func radioButtonWithTextValueChanged() {
        if self.radioButtonWithText.isSelected {
            print("라디오 버튼 선택")
        } else {
            print("라디오 버튼 선택 해제")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
