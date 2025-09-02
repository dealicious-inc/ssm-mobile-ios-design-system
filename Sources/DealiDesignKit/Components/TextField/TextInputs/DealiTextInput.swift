//
//  DealiTextInput.swift
//
//
//  Created by hoji on 2023/11/01.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

open class DealiTextInput: UIView, DealiTextField {
    
    public private(set) var textField = UITextField()
    
    // MARK: - PUBLIC
    public init() {
        super.init(frame: .zero)
        
        self.setUI()
        self.RX()
    }
    
    /// TextInput title 세팅
    public var title: String? {
        didSet {
            self.titleView.setTitle(title)
        }
    }
    
    /// 필수입력값인지 나타내는 변수. 기본값은 false.
    public var isMandatory: Bool = false {
        didSet {
            self.titleView.setMandatory(isMandatory)
        }
    }
    
    public var notVerifiedBadgeText: String? {
        didSet {
            self.titleView.setNotVerifiedBadgeText(notVerifiedBadgeText)
        }
    }
    
    public var verifiedBadgeText: String? {
        didSet {
            self.titleView.setVerifiedBadgeText(verifiedBadgeText)
        }
    }
    
    /// TextInput placeholder 세팅
    public var placeholder: String? {
        didSet {
            guard let placeholder else { return }
            self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.b2r14, .foregroundColor: UIColor.g70])
        }
    }
    
    /// textField 좌측에 위치한 text. ex) 국가코드 (+82)
    public var leftText: String? {
        didSet {
            guard let text = self.leftText, text.isEmpty == false else {
                self.textInputLeftLabel.isHidden = true
                return
            }
            
            self.textInputLeftLabel.isHidden = false
            self.textInputLeftLabel.text = text
            self.textInputLeftLabel.snp.updateConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalTo(text.size(withAttributes: [.font: UIFont.b2r14]).width + 4.0)
            }
        }
    }
    
    /// TextInput text 세팅
    public var text: String? {
        get {
            self.textField.text
        } set {
            if self.textField.text != newValue {
                self.textField.text = newValue
            }
        }
    }
    
    /// text 를 할당하고 `editingChanged`  호출하고 싶을 때 사용
    /// - Parameter text: 넣고자 하는 Text
    public func initText(_ text: String? = nil) {
        self.text = text
        self.sendEditingEvents()
    }
    
    private func sendEditingEvents() {
        guard inputStatus != .readOnly && inputStatus != .disabled else { return }
        self.textField.sendActions(for: .editingChanged)
        
        if self.inputStatus != .focusIn {
            self.textField.sendActions(for: .editingDidEnd)
        }
    }
    
    public var font: UIFont = .b2r14 {
        didSet {
            self.textField.font = self.font
        }
    }
    
    public var isConfirmed = PublishRelay<Bool>()
    
    /// 포커스 & 텍스트 있는 경우 클리어버튼 미노출할지. 기본값은 노출(isHidden = false)
    public var clearButtonShouldBeHidden: Bool = false
    
    /// TextInput ReturnKey 세팅
    public var inputReturnKeyType: UIReturnKeyType = .done {
        didSet {
            self.textField.returnKeyType = self.inputReturnKeyType
        }
    }
    
    /// TextInput 기본으로 노출되는 helperText 세팅
    public var normalHelperText: String? {
        didSet {
            self.setNormalHelperText(text: self.normalHelperText)
        }
    }
    
    public var normalHelperAttributedString: NSMutableAttributedString? {
        didSet {
            self.setNormalHelperText(attributedString: normalHelperAttributedString)
        }
    }
  
    /// 텟스트 필드에 노출되는 문자 format
    public var textInputFormat: ETextInputTextFormatType = .normal
    
    /// confirmed 속성 나타낼 때 사용
    public var confirmingCondition: ((String?) -> Bool)?
   
    /// TextInput 에러 상태 세팅
    public var errorStatus: ETextInputErrorStatus = .none {
        didSet {
            switch self.errorStatus {
            case let .error(errorMessage):
                self.setError(for: errorMessage)
                return
            default:
                break
            }
        }
    }
    
    /// TextInputStatus 따라 ui처리
    public var inputStatus: ETextInputStatus = .normal {
        didSet {
            if case .error = self.errorStatus {
                return
            }
            
            self.textField.textColor = self.inputStatus.textColor
            self.textFieldContentStackView.layer.borderColor = self.inputStatus.borderColor
            self.textFieldContentStackView.backgroundColor = self.inputStatus.backgroundColor

            switch self.inputStatus {
            case .focusIn:
                self.becomeFirstResponder()

            case .focusOut:
                self.resignFirstResponder()

            default:
                break
            }
            
            self.setNormalHelperText(text: self.normalHelperText)
            if let normalHelperAttributedString {
                self.setNormalHelperText(attributedString: normalHelperAttributedString)
            }

            self.textField.isEnabled = !(self.inputStatus == .disabled || self.inputStatus == .readOnly)
            
            if let actionButton = self.actionButton {
                actionButton.isEnabled = !(self.inputStatus == .disabled)
            }
        }
        
    }
    
    /// TextInput RightView 타입 세팅
    public var inputRightViewType: ETextInputRightViewType = .none {
        didSet {
            self.setRightView(type: self.inputRightViewType)
        }
    }
    
    /// TextInput ActionButton 세팅
    public var actionButton: ClickableUnitButtonComponent? {
        didSet {
            guard let actionButton = self.actionButton else { return }
            self.horizontalContentStackView.addArrangedSubview(actionButton)
            
            actionButton.then {
                if $0.isFixedSize == false {
                    $0.isFixedSize = true
                }
            }.snp.makeConstraints {
                $0.centerY.equalToSuperview()
            }
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
    
    /// 키보드 닫기 String을 받을경우에만 해당 버튼이 추가되도록 작업
    public var keyboardCloseButtonString: String? {
        didSet {
            guard let keyboardCloseButtonString = self.keyboardCloseButtonString else { return }
            
            let keyboardAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0)).then {
                $0.backgroundColor = .g20
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
    
    /// 최소 금액 (type이 price일경우 사용)
    public var minPrice = 0
    /// 최대 금액 (type이 price일경우 사용)
    public var maxPrice = 10000000
    /// 최소 최대 금액 밖의 가격은 입력이 안되도록
    public var blockOutOfRangePriceInput: Bool = true
    
    // MARK: - INTERNAL, PRIVATE
    private let titleView = DealiTextInputTitleView()
    public let helperTextLabel = UILabel()
    
    private let horizontalContentStackView = UIStackView()
    private let textFieldContentStackView = UIStackView()
    
    private let textInputRightTimeLabel = UILabel()
    private let textInputLeftLabel = UILabel()
    private let textInputRightImageView = UIImageView()
    
    private let clearButton = UIButton()

    private let disposeBag = DisposeBag()
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTimer(_ seconds: Int) {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        self.inputRightViewType = .timer
        self.textInputRightTimeLabel.text = formattedTime
    }

    private func RX() {
        
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
        self.rx.textEditingControlProperty
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
        
        
        /// isConfirmed 상태 표시
        Driver.merge([
            self.rx.controlEvent(.editingDidBegin).asDriver().map { _ in return true },
            self.rx.editingDidFinish.asDriver().map { _ in return false }
        ])
        .map { isFocused -> Bool in
            if let condtion = self.confirmingCondition  {
                return !isFocused && condtion(self.text)
            } else {
                return false
            }
        }
        .drive(with: self) { owner, isConfirmed in
            owner.setConfirmed(isConfirmed)
        }
        .disposed(by: self.disposeBag)

        
        Driver.merge([
            self.rx.textEditingChanged.asDriver(onErrorJustReturn: nil).map { _ in return true },
            self.rx.controlEvent(.editingDidBegin).asDriver().map { _ in return true },
            self.rx.controlEvent(.valueChanged).asDriver().map { _ in return false },
            self.rx.editingDidFinish.asDriver().map { _ in return false }
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
                owner.sendEditingEvents()
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

// MARK: - UITextFieldDelegate
extension DealiTextInput: UITextFieldDelegate {
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

// MARK: - UI Configuration
extension DealiTextInput: DealiTextFieldConfig {
    func setUI() {
        self.do {
            $0.backgroundColor = .primary04
        }
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .leading
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        stackView.addArrangedSubview(self.titleView)
        stackView.addArrangedSubview(self.horizontalContentStackView)
        self.horizontalContentStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.horizontalContentStackView.addArrangedSubview(self.textFieldContentStackView)
        self.textFieldContentStackView.then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 6.0
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.g20.cgColor
            $0.backgroundColor = .primary04
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 16.0
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 12.0)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(46.0)
        }
        
        self.textFieldContentStackView.addArrangedSubview(self.textInputLeftLabel)
        self.textInputLeftLabel.then {
            $0.font = .b2r14
            $0.textColor = .g100
            $0.textAlignment = .left
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo("(+880)".size(withAttributes: [.font: UIFont.b2r14]).width + 4.0)
        }
        
        self.textFieldContentStackView.setCustomSpacing(0.0, after: self.textInputLeftLabel)
        
        self.textFieldContentStackView.addArrangedSubview(self.textField)
        self.textField.then {
            $0.font = .b2r14
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.textColor = .g100
            $0.tintColor = .g100
            $0.delegate = self
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        self.textFieldContentStackView.addArrangedSubview(self.clearButton)
        self.clearButton.then {
            $0.isHidden = true
            
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
            configuration.image = DealiIcon.ic_x_circle_filled.image.withTintColor(.g50).resize(CGSize(width: 16.0, height: 16.0))
            $0.configuration = configuration
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        self.textFieldContentStackView.setCustomSpacing(8.0, after: self.clearButton)
        
        self.textFieldContentStackView.addArrangedSubview(self.textInputRightTimeLabel)
        self.textInputRightTimeLabel.then {
            $0.text = "00:00"
            $0.font = .b2r14
            $0.textColor = .error
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo("00:00".size(withAttributes: [.font: UIFont.b2r14]).width + 4.0)
        }
        
        self.textFieldContentStackView.addArrangedSubview(self.textInputRightImageView)
        self.textInputRightImageView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        stackView.addArrangedSubview(self.helperTextLabel)
        self.helperTextLabel.then {
            $0.font = .b4r12
            $0.textColor = .g70
            $0.highlightedTextColor = .primary01
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4.0)
        }
    }
    
    func setNormalHelperText(text: String?) {
        if let normalHelperText = self.normalHelperText {
            let style = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.12
                $0.alignment = .left
            }
            
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = NSAttributedString(string: normalHelperText, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.g70, .paragraphStyle: style])
        } else {
            self.helperTextLabel.isHidden = true
        }
        
    }
    
    func setNormalHelperText(attributedString: NSMutableAttributedString?) {
        if let attributedString  {
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = attributedString
            
        } else {
            self.helperTextLabel.isHidden = true
        }
        
    }
    
    func setError(for errorMessage: String?) {
        
        self.textField.textColor = self.errorStatus.textColor
        self.textFieldContentStackView.layer.borderColor = self.errorStatus.borderColor
        self.textFieldContentStackView.backgroundColor = self.errorStatus.backgroundColor
        
        let style = NSMutableParagraphStyle().then {
            $0.lineHeightMultiple = 1.12
            $0.alignment = .left
        }
        
        if let errorMessage = errorMessage {
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = NSAttributedString(string: errorMessage, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.error, .paragraphStyle: style])
        } else {
            if let normalHelperText = self.normalHelperText {
                self.helperTextLabel.isHidden = false
                self.helperTextLabel.attributedText = NSAttributedString(string: normalHelperText, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.g70, .paragraphStyle: style])
            } else {
                self.helperTextLabel.isHidden = true
            }
        }
    }
    
    public func setConfirmed(_ isConfirmed: Bool) {
        self.isConfirmed.accept(isConfirmed)
        
        if isConfirmed {
            self.inputRightViewType = .custom(UIImage.dealiIcon(named: "ic_check"))
            
        } else {
            self.inputRightViewType = .none

        }
    }
    
    private func setRightView(type: ETextInputRightViewType) {
        if case .custom(let image) = type {
            self.textInputRightImageView.isHidden = false
            self.textInputRightImageView.image = image
            self.textInputRightTimeLabel.isHidden = true
        } else if case .timer = type {
            self.self.textInputRightImageView.isHidden = true
            self.textInputRightTimeLabel.isHidden = false
            
        } else {
            self.self.textInputRightImageView.isHidden = true
            self.textInputRightImageView.isHidden = true
        }
    }
    
    private func requiredBadgeView() -> UIView {
        let view = UIView()
        
        let requiredBadge = UIView()
        view.addSubview(requiredBadge)
        requiredBadge.then {
            $0.backgroundColor = .primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2.5
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.0)
            $0.size.equalTo(CGSize(width: 5.0, height: 5.0))
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        return view
    }
  
}

final class DealiTextInputTitleView: UIStackView {
    
    private let titleLabel = UILabel()
    /// 필수입력사항인지 나타내는 뱃지
    private var requiredBadge = UIView()
    private let notVerifiedBadge = DealiTag()
    private let verifiedBadge = DealiTag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    func setTitle(_ title: String?) {
        guard let title = title, title.isEmpty == false else {
            self.isHidden = true
            return
        }
        
        self.isHidden = false
        self.titleLabel.text = title
    }
    
    func setMandatory(_ isMandatory: Bool) {
        self.requiredBadge.isHidden = !isMandatory
    }
    
    func setNotVerifiedBadgeText(_ text: String?) {
        guard let text = text, text.isEmpty == false else {
            self.notVerifiedBadge.isHidden = true
            return
        }
        
        self.notVerifiedBadge.isHidden = false
        self.notVerifiedBadge.text = text

    }
    
    func setVerifiedBadgeText(_ text: String?) {
        guard let text = text, text.isEmpty == false else {
            self.verifiedBadge.isHidden = true
            return
        }
        
        self.verifiedBadge.isHidden = false
        self.verifiedBadge.text = text
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.then {
            $0.axis = .horizontal
            $0.spacing = 4.0
            $0.alignment = .top
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.height.equalTo(20.0)
        }
        
        self.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = .g100
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
        }
        
        self.requiredBadge = self.requiredBadgeView()
        self.requiredBadge.isHidden = true
        self.addArrangedSubview(self.requiredBadge)
        
        self.addArrangedSubview(self.notVerifiedBadge)
        self.notVerifiedBadge.do {
            $0.type = .tagOutlineSmall01
            $0.text = "미인증"
            $0.isHidden = true
        }
        
        self.addArrangedSubview(self.verifiedBadge)
        self.verifiedBadge.do {
            $0.type = .tagOutlineSmall02
            $0.text = "인증 완료"
            $0.isHidden = true
        }
        
        self.addArrangedSubview(UIView())
    
        
    }
    
    private func requiredBadgeView() -> UIView {
        let view = UIView()
        
        let requiredBadge = UIView()
        view.addSubview(requiredBadge)
        requiredBadge.then {
            $0.backgroundColor = .primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2.5
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4.0)
            $0.size.equalTo(CGSize(width: 5.0, height: 5.0))
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        return view
    }
}
