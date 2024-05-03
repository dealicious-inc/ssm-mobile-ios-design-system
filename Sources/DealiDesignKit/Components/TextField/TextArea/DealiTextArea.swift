//
//  DealiTextArea.swift
//
//
//  Created by 윤조현 on 2024/05/02.
//

import UIKit
import RxSwift
import RxCocoa

public final class DealiTextArea: UIView, DealiTextField {
    
    
    public private(set) var textField = UITextView()
    
    var inputStatus: PublishRelay<ETextInputStatus> = .init()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
      
        
        self.inputStatus
            .bind(with: self) { owner, status in
                switch status {
                case .normal:
                    print()
                case .focusIn:
                    owner.textField.layer.borderColor = DealiColor.g100.cgColor
                case .focusOut:
                    print()
                    owner.textField.layer.borderColor = DealiColor.g20.cgColor

                case let .error(errorMsg):
                    self.setError(for: errorMsg)

                case .disabled:
                    print()

                }
            }
            .disposed(by: self.disposeBag)
        
      
        
        self.rx.editingDidBegin
            .bind(with: self) { owner, _ in
                owner.inputStatus.accept(.focusIn)
                print("포커스인 이벤트 보냄")
                
            }
            .disposed(by: self.disposeBag)
        
        self.rx.editingDidEnd
            .bind(with: self) { owner, _ in
                owner.inputStatus.accept(.focusOut)
                print("포커스아웃 이벤트 보냄")

            }
            .disposed(by: self.disposeBag)
        
        
        self.textField.rx.didChange
            .map {
                return self.textField.text.isEmpty
            }
            .distinctUntilChanged()
            .bind(with: self, onNext: { owner, isEmptyText in
                owner.placeholderLabel.isHidden = !isEmptyText
            })
            .disposed(by: self.disposeBag)
            
        
        
    }
    
    // MARK: - PUBLIC
    /// TextInput title 세팅
    public var title: String? {
        didSet {
            self.titleStackView.isHidden = false
            self.titleLabel.text = self.title
        }
    }
    
    /// 필수입력값인지 나타내는 변수. 기본값은 false.
    public var isMandatory: Bool = false {
        didSet {
            self.requiredBadge.isHidden = !self.isMandatory
        }
    }
    
    /// TextArea placeholder 세팅
    public var placeholder: String? {
        didSet {
            self.placeholderLabel.text = self.placeholder
        }
    }
    
    /// TextInput 기본으로 노출되는 helperText 세팅
    public var normalHelperText: String? {
        didSet {
            self.setNormalHelperText(text: self.normalHelperText)
        }
    }
    
    public var keyboardCloseButtonString: String? {
        didSet {
            guard let keyboardCloseButtonString = self.keyboardCloseButtonString else { return }
            
            let keyboardAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0)).then {
                $0.backgroundColor = DealiColor.g20
            }
            
            let keyboardCloseButton = DealiControl.btnTextSmall04()
            keyboardAccessoryView.addSubview(keyboardCloseButton)
            keyboardCloseButton.then {
                $0.title = keyboardCloseButtonString
            }.snp.makeConstraints {
                $0.right.equalToSuperview().offset(-12.0)
                $0.centerY.equalToSuperview()
            }
            
            self.textField.inputAccessoryView = keyboardAccessoryView
            
            keyboardCloseButton.rx.tap
                .bind(with: self) { owner, _ in
                    owner.resignFirstResponder()
                }.disposed(by: self.disposeBag)
        }
    }
    
    // MARK: Keyboard, Resonponder
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()

        return self.textField.becomeFirstResponder()
    }
    
    @discardableResult
    override public func resignFirstResponder() -> Bool {
        super.resignFirstResponder()

        return self.textField.resignFirstResponder()
    }
    
    
    
    // MARK: - INTERNAL, PRIVATE
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    /// 필수입력사항인지 나타내는 뱃지
    private let requiredBadge = UIView()
    
    private let textFieldStackView = UIStackView()
    private let placeholderLabel = UILabel()
    private let helperTextLabel = UILabel()

    
    private let disposeBag = DisposeBag()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Set UI
private extension DealiTextArea {
    /**
    ㅡㅡㅡㅡㅡㅡcontentStackView ㅡㅡㅡㅡㅡ
   ㅣ타이틀                           ㅣ
   ㅣ(좌측버튼) 텍스트필드 (우측버튼)       ㅣ
   ㅣ(helperText)                   ㅣ
    ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    */
    func setUI() {
        self.backgroundColor = DealiColor.primary04
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .center
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.titleStackView)
        self.setTitleStackView()
        
        contentStackView.addArrangedSubview(self.textFieldStackView)
        self.textFieldStackView.then {
            $0.axis = .horizontal
            $0.spacing = 10.0
            $0.alignment = .bottom
        }.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.textFieldStackView.addArrangedSubview(self.textField)
        self.textField.then {
            $0.font = .b2r14
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.textColor = DealiColor.g100
            $0.tintColor = DealiColor.g100
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 6.0
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = DealiColor.g20.cgColor
            $0.backgroundColor = DealiColor.primary04
            $0.textContainerInset = .init(top: 13.0, left: 9.0, bottom: 12.0, right: 12.0)
        }.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.height.equalTo(46.0)

        }
        
        self.textField.addSubview(self.placeholderLabel)
        self.placeholderLabel.then {
            $0.font = .b2r14
            $0.isUserInteractionEnabled = false
            $0.textColor = DealiColor.g70
            $0.textAlignment = .left
            $0.text = self.placeholder
        }.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(12.0)
        }
        
        contentStackView.addArrangedSubview(self.helperTextLabel)
        self.helperTextLabel.then {
            $0.font = .b4r12
            $0.textColor = DealiColor.g70
            $0.highlightedTextColor = DealiColor.primary01
            $0.textAlignment = .left
            $0.numberOfLines = 0
//            $0.isHidden = true
            $0.text = "helperText"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4.0)
        }
        
        
    }
    
    func setTitleStackView() {
        self.titleStackView.then {
            $0.isHidden = true
            $0.axis = .horizontal
            $0.spacing = 4.0
            $0.alignment = .top
        }.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.titleStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = DealiColor.g100
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
        }
        
        self.titleStackView.addArrangedSubview(self.requiredBadge)
        self.requiredBadge.then {
            $0.backgroundColor = DealiColor.primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2.5
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 5.0, height: 5.0))
            $0.top.equalToSuperview().inset(4.0)
        }
        
        self.titleStackView.addArrangedSubview(UIView())
    }
    
    
}

// MARK: - DealiTextFieldConfig
extension DealiTextArea: DealiTextFieldConfig {
    func setNormalHelperText(text: String?) {
      
    }
    
    func setError(for errorMessage: String?) {
        let style = NSMutableParagraphStyle().then {
            $0.lineSpacing = 4.0
            $0.lineHeightMultiple = 1.26
            $0.alignment = .left
        }
        
        if let errorMessage = errorMessage {
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = NSAttributedString(string: errorMessage, attributes: [.font: UIFont.b4r12, .foregroundColor: DealiColor.error, .paragraphStyle: style])
        } else {
            if let normalHelperText = self.normalHelperText {
                self.helperTextLabel.isHidden = false
                self.helperTextLabel.attributedText = NSAttributedString(string: normalHelperText, attributes: [.font: UIFont.b4r12, .foregroundColor: DealiColor.g70, .paragraphStyle: style])
            } else {
                self.helperTextLabel.isHidden = true
            }
        }
        self.textField.do {
            $0.layer.borderColor = DealiColor.error.cgColor
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

#Preview {
    VStack {
        UIViewPreview {
            let textArea = DealiTextArea()
            textArea.title = "Label"
            return textArea
        }
    }
}

#endif
