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
            $0.backgroundColor = .yellow
            $0.addTarget(self, action: #selector(firstRadioButtonWithTextValueChanged), for: .valueChanged)
            $0.text = "그룹 내 1 김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트 "
            $0.edgeInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200.0)
            $0.left.equalToSuperview().inset(30.0)
            $0.right.equalToSuperview().inset(30.0)
        }
        
        contentView.addSubview(self.secondRadioButtonWithText)
        self.secondRadioButtonWithText.then {
            $0.addTarget(self, action: #selector(secondRadioButtonWithTextValueChanged), for: .valueChanged)
            $0.text = "그룹내 2 김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트  김수한무 거북이와 두루미 테스트 긴글자 테스트 테스트 "
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30.0)
            $0.top.equalTo(self.firstRadioButtonWithText.snp.bottom).offset(20.0)

        }
        
        contentView.addSubview(self.radioButton)
        self.radioButton.then {
            $0.isEnabled = true
        }.snp.makeConstraints {
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
    
    @objc func firstRadioButtonWithTextValueChanged() {
        if self.firstRadioButtonWithText.isSelected {
            debugPrint("11라디오 버튼 선택")
        } else {
            debugPrint("11라디오 버튼 선택 해제")
        }
    }
    
    @objc func secondRadioButtonWithTextValueChanged() {
        if self.secondRadioButtonWithText.isSelected {
            debugPrint("22라디오 버튼 선택")
        } else {
            debugPrint("22라디오 버튼 선택 해제")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
