//
//  TextAreaViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2024/05/03.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import RxSwift
import RxCocoa
import RxKeyboard

final class TextAreaViewController: UIViewController {
    
    private let contentScrollView = UIScrollView()
    private let defaultTextArea = DealiTextArea()
    private let focusTextArea = DealiTextArea()
    private let errorTextArea = DealiTextArea()
    private let disabledTextArea = DealiTextArea()
    private let readOnlyTextArea = DealiTextArea()
    private let textAreaWithButton = DealiTextArea()

    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorTextArea.rx.editingDidEnd
            .bind(with: self) { owner, _ in
                owner.errorTextArea.inputStatus.accept(.error("에러 메시지"))
            }
            .disposed(by: self.disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardHeight in
                guard let self else { return }
                let bottomMargin = keyboardHeight > 0 ? keyboardHeight + 20.0 : 0
                self.contentScrollView.snp.updateConstraints {
                    $0.bottom.equalToSuperview().inset(bottomMargin)
                }
            })
            .disposed(by: self.disposeBag)

    }
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = DealiColor.primary04
        
        
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
            $0.spacing = 30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        contentStackView.addArrangedSubview(self.textAreaWithButton)
        self.textAreaWithButton.then {
            $0.isMandatory = true
            $0.contentType = .fixed(106.0)
            $0.placeholder = "내용을 입력해 주세요"
            $0.rightButton = UIButton().then {
                $0.setImage(UIImage.dealiIcon(named: "ic_download_1_filled"), for: .normal)
            }
            $0.leftButton = UIButton().then {
                $0.setImage(UIImage.dealiIcon(named: "ic_pluscircle_filled"), for: .normal)
            }
            $0.keyboardCloseButtonString = "닫기"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.defaultTextArea)
        self.defaultTextArea.then {
            $0.title = "Default Text Area"
            $0.isMandatory = true
            $0.placeholder = "placeholder"
            $0.normalHelperText = "HelperText"
            $0.keyboardCloseButtonString = "닫기"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.focusTextArea)
        self.focusTextArea.then {
            $0.title = "Focus Text Area"
            $0.isMandatory = true
            $0.text = "텍스트 입력 중"
            $0.normalHelperText = "HelperText"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputStatus.accept(.focusIn)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.errorTextArea)
        self.errorTextArea.then {
            $0.title = "Error Text Area"
            $0.isMandatory = true
            $0.text = "텍스트 입력"
            $0.normalHelperText = "HelperText"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputStatus.accept(.focusIn)
            $0.inputStatus.accept(.error("에러 메시지"))
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.disabledTextArea)
        self.disabledTextArea.then {
            $0.title = "Disabled Text Area"
            $0.isMandatory = true
            $0.text = "텍스트 입력"
            $0.normalHelperText = "HelperText"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputStatus.accept(.focusIn)
            $0.inputStatus.accept(.error("에러 메시지"))
            $0.inputStatus.accept(.disabled)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.readOnlyTextArea)
        self.readOnlyTextArea.then {
            $0.title = "Read Only Text Area"
            $0.isMandatory = true
            $0.text = "텍스트 입력"
            $0.normalHelperText = "HelperText"
            $0.keyboardCloseButtonString = "닫기"
            $0.inputStatus.accept(.focusIn)
            $0.inputStatus.accept(.error("에러 메시지"))
            $0.inputStatus.accept(.disabled)
            $0.inputStatus.accept(.readOnly)

        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
       
    }
}
