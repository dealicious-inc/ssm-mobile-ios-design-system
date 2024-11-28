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
    
    // MARK: - PUBLIC    
    public private(set) var textField = UITextView()
    
    public var inputStatus: PublishRelay<ETextFieldStatus> = .init()
    
    public enum ContentType {
        case flexible(min: CGFloat, max: CGFloat)
        case fixed(_ height: CGFloat = 106.0)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
      
        
        self.inputStatus
            .bind(with: self) { owner, status in
                
                owner.textField.backgroundColor = .primary04
                owner.textField.layer.borderColor = UIColor.g20.cgColor
                owner.textField.textColor = .g100
                owner.textField.isUserInteractionEnabled = true

                owner.setNormalHelperText(text: owner.normalHelperText)
                owner.placeholderLabel.textColor = .g70
                owner.textCounterLabel.textColor = .g70

                switch status {
                case .focusIn:
                    owner.textField.layer.borderColor = UIColor.g100.cgColor
                case .focusOut:
                    owner.textField.layer.borderColor = UIColor.g20.cgColor
                case let .error(errorMsg):
                    owner.setError(for: errorMsg)
                case .readOnly:
                    owner.textField.backgroundColor = .g05
                    owner.textField.layer.borderColor = UIColor.g05.cgColor
                    owner.textField.isEditable = false
                    owner.textField.isUserInteractionEnabled = false
                    owner.textField.textColor = .g80
                    owner.placeholderLabel.textColor = .g80

                case .disabled:
                    owner.textField.backgroundColor = .g10
                    owner.textField.isEditable = false
                    owner.textField.isUserInteractionEnabled = false
                    owner.textField.textColor = .g50
                    owner.placeholderLabel.textColor = .g70

                default:
                    break
                }
                
            }
            .disposed(by: self.disposeBag)

        
        self.textField.rx.didChange
            .bind(with: self) { owner, _ in
                guard case let .flexible(_, max) = owner.contentType  else { return }
                if owner.textField.contentSize.height >= max {
                    owner.setContentType(.fixed(max))
                } else {
                    owner.setContentType(owner.contentType)
                }
            }
            .disposed(by: self.disposeBag)
        
        self.textField.rx.didChange
            .scan(self.text) { (prev, _) -> String? in
                guard let maxLength = self.maxLength,
                        let text = self.text,
                        text.count > maxLength else { return self.text }
                
                return String(text.prefix(maxLength))
            }
            .bind(with: self) { owner, text in
                owner.text = text
            }
            .disposed(by: self.disposeBag)

        
        self.rx.editingDidBegin
            .bind(with: self) { owner, _ in
                owner.inputStatus.accept(.focusIn)
            }
            .disposed(by: self.disposeBag)
        
        self.rx.editingDidEnd
            .bind(with: self) { owner, _ in
                owner.inputStatus.accept(.focusOut)
            }
            .disposed(by: self.disposeBag)
        
        
        self.textField.rx.observe(String.self, "text")
            .map { $0?.isEmpty == true }
            .distinctUntilChanged()
            .bind(with: self, onNext: { owner, isEmptyText in
                owner.placeholderLabel.isHidden = !isEmptyText
            })
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
        
        self.textField.rx.didChange
            .filter { self.showTextCounter }
            .bind(with: self) { owner, _ in
                owner.textCounterLabel.text = "\(owner.text?.count ?? 0)/100"
            }
            .disposed(by: self.disposeBag)
    }
    
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
    
    /// 글자수 표시
    public var showTextCounter: Bool = false {
        didSet {
            self.textCounterLabel.isHidden = !self.showTextCounter
        }
    }
    
    /// TextInput text 세팅
    public var text: String? {
        get {
            self.textField.text
        } set {
            if self.textField.text != newValue {
                self.textField.text = newValue
                self.textCounterLabel.text = "\(newValue?.count ?? 0)/100"
            }
        }
    }
    
    public var maxLength: Int?
    
    public var contentType: ContentType = .flexible(min: 46.0, max: 106.0) {
        didSet {
            self.setContentType(self.contentType)
        }
    }
    
    
    /// 좌측 버튼
    public var leftButton: UIButton? {
        didSet {
            guard let leftButton else { return }
            self.textFieldStackView.insertArrangedSubview(leftButton, at: 0)

            leftButton.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(11.0)
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
        }
    }
    
    /// 우측 버튼
    public var rightButton: UIButton? {
        didSet {
            guard let rightButton else { return }
            
            self.textFieldStackView.addArrangedSubview(rightButton)

            rightButton.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(11.0)
                $0.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
                
            }
            
        }
    }
    
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
    private let titleStackView = UIView()
    private let titleLabel = UILabel()
    /// 필수입력사항인지 나타내는 뱃지
    private let requiredBadge = UIView()
    
    private let textFieldStackView = UIStackView()
    private let placeholderLabel = UILabel()
    private let helperTextLabel = UILabel()
    private let textCounterLabel = UILabel()

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
        self.backgroundColor = .primary04
        
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
            $0.spacing = 12.0
            $0.alignment = .bottom
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.textFieldStackView.addArrangedSubview(self.textField)
        self.textField.then {
            $0.font = .b2r14
            $0.indicatorStyle = .default
            $0.showsVerticalScrollIndicator = true
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
            $0.textColor = .g100
            $0.tintColor = .g100
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 6.0
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.g20.cgColor
            $0.backgroundColor = .primary04
            $0.textContainerInset = .init(top: 13.0, left: 9.0, bottom: 12.0, right: 12.0)
        }.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
        }
        
        self.setContentType(self.contentType)
        
        self.textField.addSubview(self.placeholderLabel)
        self.placeholderLabel.then {
            $0.font = .b2r14
            $0.isUserInteractionEnabled = false
            $0.textColor = .g70
            $0.textAlignment = .left
            $0.text = self.placeholder
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(12.0)
        }
        
        let bottomInfoStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
        }
                
        contentStackView.addArrangedSubview(bottomInfoStackView)
        bottomInfoStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(4.0)
        }

        bottomInfoStackView.addArrangedSubview(self.helperTextLabel)
        self.helperTextLabel.do {
            $0.font = .b4r12
            $0.textColor = .g70
            $0.highlightedTextColor = .primary01
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.isHidden = true
        }
        
        bottomInfoStackView.addArrangedSubview(self.textCounterLabel)
        self.textCounterLabel.do {
            $0.font = .b4r12
            $0.textColor = .g70
            $0.highlightedTextColor = .primary01
            $0.textAlignment = .right
            $0.numberOfLines = 0
            $0.isHidden = true
            $0.text = "\(self.text?.count ?? 0)/100"
        }
    }
    
    func setTitleStackView() {
        self.titleStackView.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.titleStackView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b2r14
            $0.textColor = .g100
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.setContentHuggingPriority(.required, for: .horizontal)
        }.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
        }
        
        self.titleStackView.addSubview(self.requiredBadge)
        self.requiredBadge.then {
            $0.backgroundColor = .primary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2.5
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 5.0, height: 5.0))
            $0.top.equalTo(self.titleLabel.snp.top).inset(4.0)
            $0.left.equalTo(self.titleLabel.snp.right).offset(4.0)
            $0.right.lessThanOrEqualToSuperview()
        }
    }
    
    func setContentType(_ type: ContentType) {
        switch type {
        case let .flexible(min, max):
            self.textField.then {
                $0.isScrollEnabled = false
            }.snp.remakeConstraints {
                $0.verticalEdges.equalToSuperview()
                $0.height.greaterThanOrEqualTo(min)
                $0.height.lessThanOrEqualTo(max)
            }
        case let .fixed(height):
            self.textField.then {
                $0.isScrollEnabled = true
            }.snp.remakeConstraints {
                $0.verticalEdges.equalToSuperview()
                $0.height.equalTo(height)
            }
        }
    }
    
}

// MARK: - DealiTextFieldConfig
extension DealiTextArea: DealiTextFieldConfig {
    func setNormalHelperText(text: String?) {
        let style = NSMutableParagraphStyle().then {
            $0.lineSpacing = 4.0
            $0.lineHeightMultiple = 1.26
            $0.alignment = .left
        }
        
        if let normalHelperText = text {
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = NSAttributedString(string: normalHelperText, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.g70, .paragraphStyle: style])
        } else {
            self.helperTextLabel.isHidden = true
        }
    }
    
    func setError(for errorMessage: String?) {
        self.textCounterLabel.textColor = .error
        
        let style = NSMutableParagraphStyle().then {
            $0.lineSpacing = 4.0
            $0.lineHeightMultiple = 1.26
            $0.alignment = .left
        }
        
        if let errorMessage = errorMessage {
            self.helperTextLabel.isHidden = false
            self.helperTextLabel.attributedText = NSAttributedString(string: errorMessage, attributes: [.font: UIFont.b4r12, .foregroundColor: UIColor.error, .paragraphStyle: style])
        } else {
            self.setNormalHelperText(text: self.normalHelperText)
        }
        self.textField.do {
            $0.layer.borderColor = UIColor.error.cgColor
        }
    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

#Preview {
    VStack {
        UIViewPreview {
            let defaultTextArea = DealiTextArea()
            defaultTextArea.title = "Label"
            return defaultTextArea
        }
    }
}

#endif
