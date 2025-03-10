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
    private let textInput = DealiTextInput_v2.text()
    private let contentStackView = UIStackView()
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "DealiTextInput"
        self.view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    var disposeBag = DisposeBag()
    
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
        
        
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        
        if self.isSwiftUI {
            self.setSwiftUI()
        } else {
            self.setUIKit()
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
    
    func setUIKit() {
        contentStackView.addArrangedSubview(self.textInput)
        self.textInput.then {
            $0.title = "일반 텍스트 입력"
            $0.placeholder = "Text Input"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            $0.isMandatory = true
            $0.actionButton = DealiControl.btnFilledTonalMedium03().then {
                $0.title = "Button"
            }
            $0.leftText = "(+82)"
            $0.normalHelperText = "Helper Text Will attempt to recover by breaking constraint닫기Will attempt to recover by breaking constrain"
            $0.confirmingCondition =  { text in
                return (text?.count ?? 0) > 0
            }
            $0.setTimer(245)
            
            $0.notVerifiedBadgeText = "미인증"
            $0.verifiedBadgeText = "인증"
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
            let button = DealiControl.btnOutlineMedium03()
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
            $0.inputStatus = .disabled
            $0.text = "텍스트"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnFilledTonalMedium04()
            button.title = "Default"
            $0.actionButton = button
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let urlInput = DealiTextInput_v2.url()
        contentStackView.addArrangedSubview(urlInput)
        urlInput.then {
            $0.title = "urlText 입력"
            $0.placeholder = "Text Input"
            $0.inputStatus = .readOnly
            $0.text = "readOnly 텍스트"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            let button = DealiControl.btnFilledTonalMedium04()
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
            $0.placeholder = "가격 입력"
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
        
        let disabledInput = DealiTextInput_v2()
        contentStackView.addArrangedSubview(disabledInput)
        disabledInput.then {
            $0.title = "비활성 텍스트인풋"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputReturnKeyType = .done
            $0.inputStatus = .disabled
            $0.text = "DDDD"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    func setSwiftUI() {
        contentStackView.alignment = .leading
        
        let normalInput = TextInputView()
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setMandatory()
            .setConfirmButton(title: "확인", action: {
                print("확인")
            })
            .UIKit()
        contentStackView.addArrangedSubview(normalInput)
        normalInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let timerInput = TextInputView()
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setMandatory()
            .setTimer(250)
            .UIKit()
        contentStackView.addArrangedSubview(timerInput)
        timerInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let longTextInput =  TextInputView()
            .setInputText("Text InputText InputText InputText InputText InputText InputText InputText InputText InputText Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .UIKit()
        contentStackView.addArrangedSubview(longTextInput)
        longTextInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let errorDefaultInput =  TextInputView()
            .setInputText("Error Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setInputStatus(.error(nil))
            .UIKit()
        contentStackView.addArrangedSubview(errorDefaultInput)
        errorDefaultInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let errorHelperInput =  TextInputView()
            .setInputText("Error Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setInputStatus(.error("errorMessage show"))
            .UIKit()
        contentStackView.addArrangedSubview(errorHelperInput)
        errorHelperInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let readOnlyInput =  TextInputView()
            .setInputText("ReadOnly Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setInputStatus(.readOnly)
            .UIKit()
        contentStackView.addArrangedSubview(readOnlyInput)
        readOnlyInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let disabledInput =  TextInputView()
            .setInputText("Disabled Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("Placeholder Text")
            .setInputStatus(.disabled)
            .UIKit()
        contentStackView.addArrangedSubview(disabledInput)
        disabledInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let confirmTrueInput =  TextInputView()
            .setInputText("Error Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("setConfirmed true")
            .setConfirmed(true)
            .UIKit()
        contentStackView.addArrangedSubview(confirmTrueInput)
        confirmTrueInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let confirmFalseInput =  TextInputView()
            .setInputText("Error Input")
            .setTitleText("타이틀 텍스트")
            .setHelperText("헬퍼 텍스트")
            .setPlaceholder("setConfirmed false")
            .setConfirmed(false)
            .UIKit()
        contentStackView.addArrangedSubview(confirmFalseInput)
        confirmFalseInput.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}
