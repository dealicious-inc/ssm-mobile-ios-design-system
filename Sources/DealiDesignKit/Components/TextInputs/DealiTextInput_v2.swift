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
    private let textInputRightTimerLabel = UILabel()
    private let textInputRightImageView = UIImageView()
    
    public var toastMsg: PublishRelay<ETextInputErrorToastType> = .init()
    
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
            actionButton.snp.makeConstraints {
                $0.width.equalTo(87.0)
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
    /// TextInput 기본으로 노출되는 helperText 세팅
    public var normalHelperText: String?
    /// 텍스트 필드에 노출되는 문자 format
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
            
            let keyboardCloseButton = DealiControl.btnTextSmallSecondary02()
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
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        textFieldContentStackView.addArrangedSubview(self.textInputRightTimerLabel)
        self.textInputRightTimerLabel.then {
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
        self.textField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(with: self) { owner, _ in
                owner.inputStatus = .focusIn
            }.disposed(by: self.disposeBag)
        
        // MARK: -  포커스 아웃 시 체크해야 하는 제약조건
        Signal.merge(
            self.textField.rx.controlEvent(.editingDidEnd).asSignal(),
            self.textField.rx.controlEvent(.editingDidEndOnExit).asSignal()
        )
        .emit(with: self) { owner, _ in
            owner.inputStatus = .focusOut
        }
        .disposed(by: self.disposeBag)
        
        // MARK: - 입력 때마다 체크해야 하는 제약조건
        /// 최대 글자수
        /// 최소 금액 (type이 price일경우 사용)
        /// 최대 금액 (type이 price일경우 사용)
        /// 제약문자
        ///
        /// 텍스트 inputFormat에 따라 화면에 보여지는 문자를 따로 표현 해줘야함 ( 예: "₩32,000", "10,000", "10.0" )
        /// 최대 글자수, 최소글자수, 최대금액, 최소금액 관련 대응 추가해야함
        
        self.textField.rx.text.orEmpty.asObservable()
            .scan("") { [weak self] (oldValue, newValue) in
                guard let self else { return newValue }
                return (self.isRestricted(newValue) ? oldValue : newValue)
           }
            .map { [weak self] value -> String? in
                guard let self else { return value }
                var newString = value
                
                // maxLength 검사
                if newString.count > self.maxLength {
                    self.toastMsg.accept(.maxLength)
                    newString = newString.substring(to: self.maxLength)
                }
                
                return newString
            }
           .bind(to: self.textField.rx.text)
           .disposed(by: disposeBag)
    }
    
    /// 제한이 있을 때 해당 함수 overrride 해서 사용. 들어오면 안 되는 입력값 있을 경우 true 리턴.
    public func isRestricted(_ value: String) -> Bool {
        
        return false
    }
    
    public func configure(with config: DeailTextInputConfigureProtocol?) {
        guard let config else { return }
        self.textField.keyboardType = config.keyboardType
        self.textField.textContentType = config.textContentType
        self.textField.isSecureTextEntry = config.isSecureTextEntry
        self.textInputFormat = config.textInputFormat
    }
   
    // MARK: - Timer
    /// textInput 에 타이머 필요할 때 사용하는 값. 초 단위로 입력한다.
    public var targetSeconds: Int? {
        didSet {
            guard let targetSeconds else { return }
            self.textInputRightTimerLabel.isHidden = false
            self.leftTime = targetSeconds
        }
    }
    
    /// 시간초과 시 helper text 에 보여줄 에러 문구
    public var timeoutErrorMsg: String?
    
    /// 타이머 남은 시간.
    public private(set) var leftTime: Int = 0 {
        didSet {
            self.textInputRightTimerLabel.text = self.formatTime(seconds: leftTime)
            
            if self.leftTime == 0 {
                self.task?.cancel()
                self.inputStatus = .error(self.timeoutErrorMsg ?? "")
            }
        }
    }
    
    private var task: Task<(), Error>?
    
    public func startTimer() {
        guard self.targetSeconds != nil, self.task == nil else { return }
        
        self.task = Task {
            while self.leftTime > 0 {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.leftTime -= 1
            }
        }
    }
    
    public func stopTimer() {
        guard self.targetSeconds != nil else { return }
        
        self.task?.cancel()
        self.task = nil
    }
    
    public func resetTimer() {
        guard let targetSeconds else { return }
        
        self.task?.cancel()
        self.task = nil
        self.leftTime = targetSeconds
        self.textField.endEditing(true)
        self.inputStatus = .normal
    }
    
    func formatTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]

        if let formattedString = formatter.string(from: TimeInterval(seconds)) {
            return formattedString
        } else {
            return "00:00"
        }
    }
    
    
}
