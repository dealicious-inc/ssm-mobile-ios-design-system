//
//  TextInputViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2023/11/01.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift

final class TextInputViewController: UIViewController {

    private let contentScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "DealiTextInput"
        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.timerTestView.startButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.timerTestView.textInput.startTimer()
            }
            .disposed(by: self.disposeBag)
        
        self.timerTestView.pauseButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.timerTestView.textInput.stopTimer()
            }
            .disposed(by: self.disposeBag)
        
        self.timerTestView.textInput.changedText
            .drive(onNext: { [weak self] text in
                print("text: \(text)")
            })
            .disposed(by: self.disposeBag)
            
        self.timerTestView.resetButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.timerTestView.textInput.resetTimer()
            }
            .disposed(by: self.disposeBag)
    }
    
    let timerTestView = TextInputTimerTestView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        self.contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 50.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }

        contentStackView.addArrangedSubview(self.timerTestView)
        self.timerTestView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let maxLengthTextInput = DealiTextInput_v2.text()
        contentStackView.addArrangedSubview(maxLengthTextInput)
        maxLengthTextInput.then {
            $0.title = "최대 글자수 제한 텍스트필드"
            $0.placeholder = "5자까지 입력가능"
            $0.maxLength = 5
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnOutlineMediumPrimary01()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        
        let textInput = DealiTextInput_v2.text()
        contentStackView.addArrangedSubview(textInput)
        textInput.then {
            $0.title = "일반 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnOutlineMediumPrimary01()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let numberInput = DealiTextInput_v2.number()
        contentStackView.addArrangedSubview(numberInput)
        numberInput.then {
            $0.title = "숫자 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnOutlineMediumSecondary01()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let emailInput = DealiTextInput_v2.email()
        contentStackView.addArrangedSubview(emailInput)
        emailInput.then {
            $0.title = "이메일 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnFilledTonalMediumSecondary02()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let urlInput = DealiTextInput_v2.url()
        contentStackView.addArrangedSubview(urlInput)
        urlInput.then {
            $0.title = "이메일 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnFilledTonalMediumSecondary02()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let phoneInput = DealiTextInput_v2.phone()
        contentStackView.addArrangedSubview(phoneInput)
        phoneInput.then {
            $0.title = "폰번호 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let priceInput = DealiTextInput_v2.price()
        contentStackView.addArrangedSubview(priceInput)
        priceInput.then {
            $0.title = "가격 텍스트 입력"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let passwordInput = DealiTextInput_v2.password()
        contentStackView.addArrangedSubview(passwordInput)
        passwordInput.then {
            $0.title = "패스워드 텍스트 입력"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height, right: 0.0)
        self.contentScrollView.contentInset = contentInset
        self.contentScrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        self.contentScrollView.contentInset = contentInset
        self.contentScrollView.scrollIndicatorInsets = contentInset
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
}


class TextInputTimerTestView: UIView {
    
    let textInput = DealiTextInput_v2.text()
    let startButton = DealiControl.btnFilledTonalMediumSecondary01()
    let pauseButton = DealiControl.btnFilledTonalMediumSecondary01()
    let resetButton = DealiControl.btnFilledTonalMediumSecondary01()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.textInput)
        self.textInput.then {
            $0.title = "타이머 테스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            
            $0.targetSeconds = 3
            $0.timeoutErrorMsg = "시간초과 에러메시지"
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        let buttonStackView = UIStackView()
        self.addSubview(buttonStackView)
        
        buttonStackView.then {
            $0.axis = .horizontal
            $0.spacing = 20.0
            $0.distribution = .fillEqually
        }.snp.makeConstraints {
            $0.top.equalTo(self.textInput.snp.bottom).offset(30.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
        buttonStackView.addArrangedSubview(self.startButton)
        self.startButton.title = "시작"
        
        buttonStackView.addArrangedSubview(self.pauseButton)
        self.pauseButton.title = "일시중지"

        buttonStackView.addArrangedSubview(self.resetButton)
        self.resetButton.title = "초기화"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
