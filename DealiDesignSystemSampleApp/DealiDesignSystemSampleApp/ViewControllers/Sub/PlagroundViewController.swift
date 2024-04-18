//
//  PlagroundViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2024/04/16.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxCocoa
import OSLog
import Then

final class PlagroundViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playground"
    }
        
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        let textInputView = TextInputValidationView()
        contentStackView.addArrangedSubview(textInputView)
    }

}


final class TextInputValidationView: UIView {
    
    
    private let disposeBag = DisposeBag()
    private let textInput = DealiTextInput_v2()
    
    var option: DealiCharaterOptions = [.alphabet, .numeric]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        
        self.textInput.changedTextControlProperty
            .orEmpty
            .changed
            .scan(self.textInput.text ?? "") { _, current in
                return current.filteredText(with: .restrict(self.option))
            }
            .bind(with: self) { owner, text in
                owner.textInput.text = text
            }
            .disposed(by: self.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.then {
            $0.font = .h2sb24
            $0.text = "TextInput Validation Test"
            $0.backgroundColor = DealiColor.secondary03
            $0.textColor = .black
        }.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        let validateWhileEditingLabel = UILabel()
        self.addSubview(validateWhileEditingLabel)
        validateWhileEditingLabel.then {
            $0.font = .sh1sb20
            $0.text = "1. 입력할 때마다 검사"
            $0.textColor = .black
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            $0.left.equalToSuperview()
        }
       
        // 최대, 최소글자
        // 이모지, 영어, 한글, 특수문자,
        
        let restrictionLabel = UILabel()
        self.addSubview(restrictionLabel)

        restrictionLabel.then {
            $0.font = .sh2sb18
            $0.text = "1.1. 입력제한 문자"
            $0.textColor = .black
        }.snp.makeConstraints {
            $0.top.equalTo(validateWhileEditingLabel.snp.bottom).offset(20.0)
            $0.left.equalToSuperview()
        }
        
        let optionStackView = UIStackView()
        self.addSubview(optionStackView)
        optionStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 5.0
        }.snp.makeConstraints {
            $0.top.equalTo(restrictionLabel.snp.bottom).offset(10.0)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32.0)
        }
       
        DealiCharaterOptions.allCases.forEach { option in
            let chip = DealiControl.chipOutlineSmall01().then {
                $0.title = option.description
            }
            optionStackView.addArrangedSubview(chip)
            
            chip.rx.tap
                .bind(with: self) { owner, _ in
                    chip.isSelected.toggle()
                    if chip.isSelected {
                        owner.option = owner.option.union(option)
                    } else {
                        owner.option.subtract(option)
                    }
                }
                .disposed(by: self.disposeBag)
            
        }
        
        self.addSubview(self.textInput)
        self.textInput.then {
            $0.placeholder = "테스트할 텍스트 입력"
            $0.inputRightViewType = .clear
            $0.inputReturnKeyType = .done
        }.snp.makeConstraints {
            $0.top.equalTo(optionStackView.snp.bottom).offset(20.0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
}
