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
import RxKeyboard
import OSLog
import Then

final class PlagroundViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Playground"
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardHeight in
                guard let self else { return }
                let bottomMargin = keyboardHeight > 0 ? keyboardHeight + 20.0 : 0
                self.scrollView.snp.updateConstraints {
                    $0.bottom.equalToSuperview().inset(bottomMargin)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        
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
    private let restrictedTextInput = DealiTextInput_v2()
    private var restrictionOption: DealiCharaterOptions = []
    private var restritionErrorMsg: [DealiCharaterOptions: String] = [.alphabet: "알파벳 금지", .numeric: "숫자 금지", .korean: "한글 금지", .japanese: "가나 금지", .specialCharacter: "특문 금지"]

    private let allowedTextInput = DealiTextInput_v2()
    private var allowingOption: DealiCharaterOptions = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        
        self.restrictedTextInput.changedTextControlProperty
            .orEmpty
            .changed
            .scan(self.restrictedTextInput.text ?? "") { _, current in
                
                if let character = self.restrictedTextInput.text?.unicodeScalars
                    .first(where: { self.restrictionOption.characterSet.contains($0) }),
                   let type = self.restrictionOption.type(for: CharacterSet(charactersIn: String(character))) {
                    
                    debugPrint(self.restritionErrorMsg[type] ?? "")
                }
                
                let result = current.filteredText(for: .restrict(self.restrictionOption))
                switch result.condition {
                case let .some(condition):
                    switch condition {
                        
                    case .length(min: let min, max: let max):
                        ""
                    case .allow(_):
                        ""
                    case let .restrict(option):
                        if let errorCharacter = current.unicodeScalars.first(where: { option.characterSet.contains($0)}),
                           let type = self.restrictionOption.type(for: CharacterSet(charactersIn: String(errorCharacter))),
                           let errorMsg = self.restritionErrorMsg[type] {
                            debugPrint(errorMsg)
                        }
                    }
                default:
                    print("성공")
                    break
                }
                
                return current.filteredText(with: .restrict(self.restrictionOption))
            }
            .bind(with: self) { owner, text in
                owner.restrictedTextInput.text = text
            }
            .disposed(by: self.disposeBag)
        
        self.allowedTextInput.changedTextControlProperty
            .orEmpty
            .changed
            .scan(self.allowedTextInput.text ?? "") { _, current in
                return current.filteredText(with: .allow(self.allowingOption))
            }
            .bind(with: self) { owner, text in
                owner.allowedTextInput.text = text
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
        
        // MARK: - 입력제한 문자
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
                        owner.restrictionOption = owner.restrictionOption.union(option)
                    } else {
                        owner.restrictionOption.subtract(option)
                    }
                }
                .disposed(by: self.disposeBag)
            
        }
        
        self.addSubview(self.restrictedTextInput)
        self.restrictedTextInput.then {
            $0.placeholder = "테스트할 텍스트 입력"
            $0.inputRightViewType = .clear
            $0.inputReturnKeyType = .done
            $0.title = "입력제한 문자 테스트 TextInput"
        }.snp.makeConstraints {
            $0.top.equalTo(optionStackView.snp.bottom).offset(20.0)
            $0.left.right.equalToSuperview()
        }
        
        // MARK: - 입력허용 문자
        let allowingLabel = UILabel()
        self.addSubview(allowingLabel)

        allowingLabel.then {
            $0.font = .sh2sb18
            $0.text = "1.2. 입력허용 문자"
            $0.textColor = .black
        }.snp.makeConstraints {
            $0.top.equalTo(self.restrictedTextInput.snp.bottom).offset(20.0)
            $0.left.equalToSuperview()
        }

        let allowingOptionStackView = UIStackView()
        self.addSubview(allowingOptionStackView)
        allowingOptionStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 5.0
        }.snp.makeConstraints {
            $0.top.equalTo(allowingLabel.snp.bottom).offset(10.0)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32.0)
        }

        DealiCharaterOptions.allCases.forEach { option in
            let chip = DealiControl.chipOutlineSmall01().then {
                $0.title = option.description
            }
            allowingOptionStackView.addArrangedSubview(chip)

            chip.rx.tap
                .bind(with: self) { owner, _ in
                    chip.isSelected.toggle()

                    if chip.isSelected {
                        owner.allowingOption = owner.allowingOption.union(option)
                    } else {
                        owner.allowingOption.subtract(option)
                    }
                }
                .disposed(by: self.disposeBag)
        }

        self.addSubview(self.allowedTextInput)
        self.allowedTextInput.then {
            $0.placeholder = "테스트할 텍스트 입력"
            $0.inputRightViewType = .clear
            $0.inputReturnKeyType = .done
            $0.title = "입력허용 문자 테스트 TextInput"
        }.snp.makeConstraints {
            $0.top.equalTo(allowingOptionStackView.snp.bottom).offset(20.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
}
