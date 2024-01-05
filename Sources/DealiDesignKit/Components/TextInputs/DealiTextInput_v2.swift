//
//  DealiTextInput_v2.swift
//
//
//  Created by hoji on 2023/11/01.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

public final class DealiTextInput_v2: UIView {
    
    private let titleLabel = UILabel()
    private let helperTextLabel = UILabel()
    
    private let textFieldButtonStackView = UIStackView()
    private let textFieldContentView = UIView()
    private let textField = UITextField()
    private let textInputRightTimeLabel = UILabel()
    private let textInputRightImageView = UIImageView()
    
    public var textFieldDidEndEditing: Driver<Bool>!
    
    private let disposeBag = DisposeBag()
    
    /// TextInput title 세팅
    public var title: String? {
        didSet {
            self.titleLabel.isHidden = false
            self.titleLabel.text = self.title
        }
    }
    /// TextInput placeholder 세팅
    public var placeholder: String? {
        didSet {
            guard let placeholder else { return }
            self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.b2r14, .foregroundColor: DealiColor.g70])
        }
    }
    /// TextInput text 세팅
    public var text: String? {
        get {
            self.textField.text
        } set {
            self.textField.text = newValue
        }
    }
    /// TextInput ReturnKey 세팅
    public var inputReturnKeyType: UIReturnKeyType = .done {
        didSet {
            self.textField.returnKeyType = self.inputReturnKeyType
        }
    }
    /// TextInput ActionButton 세팅
    public var actionButton: ClickableComponentButton? {
        didSet {
            guard let actionButton = self.actionButton else { return }
            self.textFieldButtonStackView.addArrangedSubview(actionButton)
            
            actionButton.then {
                if $0.isFixedSize == false {
                    $0.isFixedSize = true
                }
            }.snp.makeConstraints {
                $0.centerY.equalToSuperview()
            }
        }
    }
    /// 최소 글자수
    public var minLength = 0
    /// 최대 글자수
    public var maxLength = 100
    /// 최소 금액 (type이 price일경우 사용)
    public var minPrice = 0
    /// 최대 금액 (type이 price일경우 사용)
    public var maxPrice = 10000000
    /// 최소 최대 금액 밖의 가격은 입력이 안되도록
    public var blockOutOfRangePriceInput: Bool = true
    /// TextInput 기본으로 노출되는 helperText 세팅
    public var normalHelperText: String?
    /// 텟스트 필드에 노출되는 문자 format
    public var textInputFormat: ETextInputTextFormatType = .normal
    /// TextInputStatus 따라 ui처리
    public var inputStatus: ETextInputStatus = .normal {
        didSet {
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 4.0
            style.lineHeightMultiple = 1.26
            style.alignment = .left
            
            switch self.inputStatus {
            case .error(let errorMessage):
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
                self.textFieldContentView.do {
                    $0.layer.borderColor = DealiColor.error.cgColor
                }
                
            default:
                if let normalHelperText = self.normalHelperText {
                    self.helperTextLabel.isHidden = false
                    self.helperTextLabel.attributedText = NSAttributedString(string: normalHelperText, attributes: [.font: UIFont.b4r12, .foregroundColor: DealiColor.g70, .paragraphStyle: style])
                } else {
                    self.helperTextLabel.isHidden = true
                }
                
                self.textField.isEnabled = !(self.inputStatus == .disabled)
                self.textFieldContentView.layer.borderColor = (self.inputStatus == .focusIn ? DealiColor.g100.cgColor : DealiColor.g20.cgColor)
                self.textFieldContentView.backgroundColor = (self.inputStatus == .disabled ? DealiColor.g10 : DealiColor.primary04)
                
                if let actionButton = self.actionButton {
                    actionButton.isEnabled = !(self.inputStatus == .disabled)
                }
            }
        }
    }
    /// 키보드 닫기 String을 받을경우에만 해당 버튼이 추가되도록 작업
    public var keyboardCloseButtonString: String? {
        didSet {
            guard let keyboardCloseButtonString = self.keyboardCloseButtonString else { return }
            
            let keyboardAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0))
            keyboardAccessoryView.do {
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
            
            keyboardCloseButton.rx.tap.subscribe(with: self) { owner, _ in
                owner.textField.endEditing(true)
            }.disposed(by: self.disposeBag)
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        self.do {
            $0.backgroundColor = DealiColor.primary04
        }
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .center
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = DealiColor.g100
            $0.textAlignment = .left
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        
        contentStackView.addArrangedSubview(self.textFieldButtonStackView)
        self.textFieldButtonStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.textFieldButtonStackView.addArrangedSubview(self.textFieldContentView)
        self.textFieldContentView.then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 6.0
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = DealiColor.g20.cgColor
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(46.0)
        }
        
        let textFieldContentStackView = UIStackView()
        self.textFieldContentView.addSubview(textFieldContentStackView)
        textFieldContentStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 14.0
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        textFieldContentStackView.addArrangedSubview(self.textField)
        self.textField.then {
            $0.font = .b2r14
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.textColor = DealiColor.g100
            $0.tintColor = DealiColor.g100
            $0.delegate = self
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        textFieldContentStackView.addArrangedSubview(self.textInputRightTimeLabel)
        self.textInputRightTimeLabel.then {
            $0.text = "00:00"
            $0.font = .b2r14
            $0.textColor = DealiColor.error
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo("00:00".size(withAttributes: [.font: UIFont.b2r14]).width + 4.0)
        }
        
        textFieldContentStackView.addArrangedSubview(self.textInputRightImageView)
        self.textInputRightImageView.then {
            $0.backgroundColor = .red
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        contentStackView.addArrangedSubview(self.helperTextLabel)
        self.helperTextLabel.then {
            $0.font = .b4r12
            $0.textColor = DealiColor.g70
            $0.highlightedTextColor = DealiColor.primary01
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4.0)
        }
        
        self.RX()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func RX() {
        self.textFieldDidEndEditing = Driver.merge(
            self.textField.rx.controlEvent(.editingDidEndOnExit)
                .map { true }
                .asDriver(onErrorJustReturn: false),
            self.textField.rx.controlEvent(.editingDidEnd)
                .map { true }
                .asDriver(onErrorJustReturn: false)
        )
        
        self.textField.rx.controlEvent(.editingDidBegin).asSignal().emit(with: self) { owner, _ in
            self.inputStatus = .focusIn
        }.disposed(by: self.disposeBag)
        
        self.textField.rx.controlEvent(.editingDidEnd).asSignal().emit(with: self) { owner, _ in
            self.inputStatus = .focusOut
        }.disposed(by: self.disposeBag)
        
        /// 텍스트 inputFormat에 따라 화면에 보여지는 문자를 따로 표현 해줘야함 ( 예: "₩32,000", "10,000", "10.0" )
        /// 최대 글자수, 최소글자수, 최대금액, 최소금액 관련 대응 추가해야함
        self.textField.rx.text
            .orEmpty
            .changed
            .skip(1)
            .distinctUntilChanged()
            .subscribe(with: self, onNext: { owner, text in
//                print("DealiTextInput_v2_ text.changed = \(text) / \(text.count)")
                if
                    owner.textInputFormat == .price,
                    let price = Int(text.replacingOccurrences(of: ",", with: ""))
                {
                    owner.textField.text = price.commaString()
                }
            })
            .disposed(by: self.disposeBag)
        
    }
    
    public func configure(configure: DeailTextInputConfigureProtocol?) {
        guard let configure = configure else { return }
        self.textField.keyboardType = configure.keyboardType
        self.textField.textContentType = configure.textContentType
        self.textField.isSecureTextEntry = configure.isSecureTextEntry
        self.textInputFormat = configure.textInputFormat
    }
}

extension Int {
    internal func commaString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "ko_KR")
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension DealiTextInput_v2: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard self.textInputFormat == .price else { return true }
        
        let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        
        guard
            self.blockOutOfRangePriceInput,
            var currentPriceText = textField.text?.replacingOccurrences(of: ",", with: ""),
            !currentPriceText.trim().isEmpty
        else { return isNumber || string.isEmpty }
        
        if string.isEmpty {
            currentPriceText.removeLast()
        } else {
            currentPriceText += string
        }
        
        guard let price = Int(currentPriceText) else { return isNumber || string.isEmpty }
        
        return price <= maxPrice && price >= minPrice
    }
}
