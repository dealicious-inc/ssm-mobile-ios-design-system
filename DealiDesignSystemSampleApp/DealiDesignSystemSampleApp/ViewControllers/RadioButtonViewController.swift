//
//  RadioButtonViewController.swift
//  
//
//  Created by JohyeonYoon on 2023/08/31.
//

import UIKit
import DealiDesignKit

    
final class RadioButtonViewController: UIViewController {
    
    let radioButtonManager = UIControlManager()

    let firstRadioButtonWithText = DealiRadioButtonWithText()
    let secondRadioButtonWithText = DealiRadioButtonWithText()
    let radioButton = DealiRadioButton()
    let disabledRadioButton = DealiRadioButton()

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
        
        radioButtonManager.addExclusiveControl(firstRadioButtonWithText)
        radioButtonManager.addExclusiveControl(secondRadioButtonWithText)
        radioButtonManager.addExclusiveControl(radioButton)
        
        contentView.addSubview(self.firstRadioButtonWithText)
        self.firstRadioButtonWithText.then {
            $0.text = "그룹 내 1"
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(30.0)
            $0.left.equalToSuperview().inset(30.0)
        }
        
        contentView.addSubview(self.secondRadioButtonWithText)
        self.secondRadioButtonWithText.then {
            $0.addTarget(self, action: #selector(radioButtonWithTextValueChanged), for: .valueChanged)
            $0.text = "그룹내 2"
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.firstRadioButtonWithText.snp.bottom).offset(20.0)
        }
        
        contentView.addSubview(self.radioButton)
        self.radioButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.secondRadioButtonWithText.snp.bottom).offset(20.0)
        }
        
        contentView.addSubview(self.disabledRadioButton)
        self.disabledRadioButton.then {
            $0.isEnabled = false
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.radioButton.snp.bottom).offset(20.0)
        }
        
  
        contentView.addSubview(self.disabledRadioButtonWithText)
        self.disabledRadioButtonWithText.then {
            $0.isEnabled = false
            $0.text = "김수한무거북이와두루미"
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.disabledRadioButton.snp.bottom).offset(20.0)
        }
    }
    
    @objc func radioButtonValueChanged() {
        if self.radioButton.isSelected {
            print("11라디오 버튼 선택")
        } else {
            print("11라디오 버튼 선택 해제")
        }
    }
    
    @objc func radioButtonWithTextValueChanged() {
        if self.secondRadioButtonWithText.isSelected {
            print("22라디오 버튼 선택")
        } else {
            print("22라디오 버튼 선택 해제")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
