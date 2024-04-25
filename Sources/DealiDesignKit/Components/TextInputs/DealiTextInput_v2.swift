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
    let textField = UITextField()
    
    private let textInputRightTimeLabel = UILabel()
    private let textInputRightImageView = UIImageView()
    
    private let clearButton = UIButton()
    
    /// 포커스 아웃 이벤트 모두 담은 Driver
    public var textFieldDidEndEditing: Driver<Bool>!

    /// return, next 키 등 눌렀을 때 포커스 조정 등의 처리를 위한 Driver
    public var editingDidEndOnExit: Driver<Void>!
    public var editingDidEnd: Driver<Void>!
    
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
    
    public var font: UIFont = .b2r14 {
        didSet {
            self.textField.font = self.font
        }
    }
    
    /// 포커스 & 텍스트 있는 경우 클리어버튼 미노출할지. 기본값은 노출(isHidden = false)
    public var clearButtonShouldBeHidden: Bool = false
    
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
   
    //    /// 최소 금액 (type이 price일경우 사용)
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
            
            switch self.inputStatus {
            case .error(let errorMessage):
                self.setError(for: errorMessage)
                return
            case .focusIn:
                self.becomeFirstResponder()

            case .focusOut:
                self.resignFirstResponder()

            default:
                break
            }
            
            if let normalHelperText = self.normalHelperText {
                let style = NSMutableParagraphStyle().then {
                    $0.lineSpacing = 4.0
                    $0.lineHeightMultiple = 1.26
                    $0.alignment = .left
                }
                
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
            
            switch self.inputRightViewType {
        
            default:
                self.textInputRightImageView.isHidden = true
            }
        }
        
    }
    
    private func setError(for errorMessage: String?) {
        
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
        self.textFieldContentView.do {
            $0.layer.borderColor = DealiColor.error.cgColor
        }
    }
    
    
    /// 키보드 닫기 String을 받을경우에만 해당 버튼이 추가되도록 작업
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
    
    /// TextInput RightView 타입 세팅
    public var inputRightViewType: ETextInputRightViewType = .none
    
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
        
        textFieldContentStackView.addArrangedSubview(self.clearButton)
        self.clearButton.then {
            $0.isHidden = true
            $0.setImage(UIImage.dealiIcon(named: "ic_x_circle_filled")?.withTintColor(DealiColor.g50), for: .normal)
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
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
    
    public var changedTextControlProperty: ControlProperty<String?> {
        return self.textField.rx.controlProperty(
            editingEvents: [.editingChanged, .valueChanged],
            getter: { textField in
                textField.text
            },
            setter: { textField, value in
                if self.textField.text != value {
                    self.textField.text = value
                }
            }
        )
    }
    
    
    private func RX() {
        
        self.editingDidEndOnExit = self.rx.controlEvent(.editingDidEndOnExit)
            .map { return }
            .asDriver(onErrorJustReturn: ())
        
        self.editingDidEnd = self.rx.controlEvent(.editingDidEnd)
            .map { return }
            .asDriver(onErrorJustReturn: ())
        
        self.textFieldDidEndEditing = Driver.merge([self.editingDidEnd, self.editingDidEndOnExit]).map { true }
        
        self.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(with: self) { owner, _ in
                owner.inputStatus = .focusIn
            }.disposed(by: self.disposeBag)
        
        self.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(with: self) { owner, _ in
                owner.inputStatus = .focusOut
            }.disposed(by: self.disposeBag)
        
        /// 텍스트 inputFormat에 따라 화면에 보여지는 문자를 따로 표현 해줘야함 ( 예: "₩32,000", "10,000", "10.0" )
        /// 최대 글자수, 최소글자수, 최대금액, 최소금액 관련 대응 추가해야함
        self.changedTextControlProperty
            .orEmpty
            .changed
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                if owner.textInputFormat == .price,
                   let price = Int(text.replacingOccurrences(of: ",", with: "")) {
                    owner.textField.text = price.commaString()
                }
            }
            .disposed(by: self.disposeBag)
        
        Driver.merge([
            self.changedTextControlProperty.asDriver().map { _ in return true },
            self.rx.controlEvent(.editingDidBegin).asDriver().map { _ in return true },
            self.textFieldDidEndEditing.asDriver().map { _ in return false }
        ])
        .map { isFocused -> Bool in
            
            guard self.clearButtonShouldBeHidden == false else { return true }
            
            // 포커스 && 한 글자라도 입력 시에만 clearButton 노출
            return !(isFocused && !(self.text ?? "").isEmpty)
        }
        .drive(with: self) { owner, isClearButtonHidden in
            owner.clearButton.isHidden = isClearButtonHidden
        }
        .disposed(by: self.disposeBag)
        
        self.clearButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.text = nil
                owner.clearButton.isHidden = true
            }
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

public extension Reactive where Base: DealiTextInput_v2 {
    
    func controlEvent(_ controlEvents: UIControl.Event) -> ControlEvent<()> {
        return base.textField.rx.controlEvent(controlEvents)
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

extension Int {
    func commaString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "ko_KR")
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
