//
//  DealiSearchInput.swift
//
//
//  Created by 조서현 on 2023/11/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

/**
 설명: UI Elements - SearchInput
 */

public protocol DealiSearchInputDelegate: AnyObject {
    func search(keyword: String?)
    func clear()
    func beginEditing()
    func endEditing()
    func editingChanged(keyword: String?)
}

public final class DealiSearchInput: UIView {
    
    // MARK: Enum Types
    private enum SearchInputType: Equatable {
        case `default`
        case subKeyword
    }
    
    private enum SearchStatus {
        case `default`
        case editing
    }
    
    // MARK: - Constants
    private enum Constants {
        /// 검색어 TextField 관련 상수 모음
        static let font: UIFont = .systemFont(ofSize: 14)
        static let placeholderColor: UIColor = DealiColor.g60
        static let textColor: UIColor = DealiColor.g100
        
        /// search image 관련 상수 모음
        static let imageSearch: UIImage? = UIImage.dealiIcon(named: "ic_search")
        static let imageClear: UIImage? = UIImage.dealiIcon(named: "ic_x_circle_filled")?.withTintColor(DealiColor.g50)
        static let imageSearchSize: CGFloat = 24
        static let imageClearSize: CGFloat = 16
    }
    
    private enum StackViewConstants {
        /// StackView 관련 상수 모음
        static let radius: CGFloat = 6
        static let height: CGFloat = 40
        static let backgroundColor: UIColor = DealiColor.g10
        static let spacing: CGFloat = 16
        static let layoutHMargin: CGFloat = 16
        static let layoutVMargin: CGFloat = 6
    }
    
    private enum SubKeywordViewConsants {
        /// Sub Keyword View 관련 상수 모음
        static let backgroundColor: UIColor = DealiColor.primary04
        static let radius: CGFloat = 6
        static let borderColor: UIColor = DealiColor.g20
        static let borderWidth: CGFloat = 1
        static let maxWidth: CGFloat = 92
        static let textColor: UIColor = DealiColor.g80
        static let font: UIFont = .systemFont(ofSize: 14, weight: .bold)
    }
    
    // MARK: - Variables
    private let stackView = UIStackView()
    private let placeHolderLabel = UILabel()
    private let searchTextField = UITextField()
    private let clearImageView = UIImageView()
    private let searchImageView = UIImageView()
    private var subKeywordLabel: UILabel?
    private var inputType: SearchInputType = .default {
        didSet {
            self.updateKeyword(keyword)
        }
    }
    private weak var delegate: DealiSearchInputDelegate?
    private let disposeBag = DisposeBag()
    
    /// keyword 세팅
    public var keyword: String? {
        get {
            self.searchTextField.text
        }
        set {
            self.updateKeyword(newValue)
        }
    }
    
    /// placeholder 세팅
    public var placeholder: String? {
        didSet {
            self.placeHolderLabel.text = placeholder
        }
    }
    
    /// Sub keyword 세팅
    public var subKeyword: String? {
        didSet {
            if let subKeyword {
                self.setSubKeywordView(with: subKeyword)
                self.inputType = .subKeyword
            }
        }
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            self.searchTextField.keyboardType = self.keyboardType
        }
    }
    
    /// clear 버튼 탭 시 텍스트 초기화. false인 경우  동작없음
    public var resetKeywordWhenClearTapped: Bool = true
    // BeginEditing 시 status ui 업데이트 여부 결정. false인 경우 업데이트 없음
    public var shouldUpdateStatusOnBeginEditing: Bool = true
    
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
            
            self.searchTextField.inputAccessoryView = keyboardAccessoryView
            
            keyboardCloseButton.rx.tap.subscribe(with: self) { owner, _ in
                owner.searchTextField.endEditing(true)
            }.disposed(by: self.disposeBag)
        }
    }
    
    // MARK: - Initializer
    public init(keyword: String = "", placeholder: String = "", delegate: DealiSearchInputDelegate?) {
        super.init(frame: .zero)
        setContainerStackView()
        setTextField()
        setSearchStatusImage()
        
        self.keyword = keyword
        self.placeholder = placeholder
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    public func updateKeyword(_ keyword: String?) {
        guard let keyword, !keyword.isEmpty else {
            searchTextField.text = nil
            setSearchBarAs(status: searchTextField.isEditing ? .editing : .default)
            return
        }
        searchTextField.text = keyword
        setSearchBarAs(status: searchTextField.isEditing ? .editing : .default)
    }
    
    public func updateSubKeyword(_ keyword: String?) {
        guard let keyword, !keyword.isEmpty else { return }
        setSubKeywordView(with: keyword)
    }
}

// MARK: - Setup
extension DealiSearchInput {
    // MARK: UI Setup
    private func setContainerStackView() {
        addSubview(stackView)
        stackView.then {
            $0.backgroundColor = StackViewConstants.backgroundColor
            $0.setCornerRadius(StackViewConstants.radius)
            $0.spacing = StackViewConstants.spacing
            $0.alignment = .fill
            $0.distribution = .fill
            $0.layoutMargins = UIEdgeInsets(
                top: StackViewConstants.layoutVMargin
                , left: StackViewConstants.layoutHMargin
                , bottom: StackViewConstants.layoutVMargin
                , right: StackViewConstants.layoutHMargin
            )
            $0.isLayoutMarginsRelativeArrangement =  true
            $0.axis = .horizontal
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(StackViewConstants.height)
        }
    }
    
    private func setTextField() {
        let textInputContainer = UIView()
        stackView.addArrangedSubview(textInputContainer)
        textInputContainer.do {
            $0.backgroundColor = .clear
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
        
        textInputContainer.addSubview(placeHolderLabel)
        placeHolderLabel.then {
            $0.textColor = Constants.placeholderColor
            $0.font = Constants.font
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textInputContainer.addSubview(searchTextField)
        searchTextField.then {
            $0.textColor = Constants.textColor
            $0.font = Constants.font
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .clear
            $0.returnKeyType = .search
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.spellCheckingType = .no
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        RX()
    }
    
    private func setSearchStatusImage() {
        stackView.addArrangedSubview(clearImageView)
        clearImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = true
            $0.image = Constants.imageClear
        }.snp.makeConstraints {
            $0.width.equalTo(Constants.imageClearSize)
        }
        stackView.setCustomSpacing(12, after: clearImageView)
        
        stackView.addArrangedSubview(searchImageView)
        searchImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = false
            $0.image = Constants.imageSearch
        }.snp.makeConstraints {
            $0.width.equalTo(Constants.imageSearchSize)
        }
        
        clearImageView.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.textFieldClearTapped()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setSubKeywordView(with keyword: String) {
        if let subKeywordLabel {
            subKeywordLabel.text = keyword
        } else {
            let keywordView = UIView()
            stackView.insertArrangedSubview(keywordView, at: 0)
            keywordView.then {
                $0.backgroundColor = SubKeywordViewConsants.backgroundColor
                $0.setCornerRadius(
                    SubKeywordViewConsants.radius
                    , borderWidth: SubKeywordViewConsants.borderWidth
                    , borderColor: SubKeywordViewConsants.borderColor
                )
                $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            }.snp.makeConstraints {
                $0.width.lessThanOrEqualTo(SubKeywordViewConsants.maxWidth)
            }
            
            let keywordLabel = UILabel()
            keywordView.addSubview(keywordLabel)
            keywordLabel.then {
                $0.textColor = SubKeywordViewConsants.textColor
                $0.font = SubKeywordViewConsants.font
                $0.textAlignment = .center
                $0.lineBreakMode = .byTruncatingTail
                $0.text = keyword
                $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(4)
                $0.left.right.equalToSuperview().inset(8)
                $0.centerX.equalToSuperview()
            }
            
            stackView.setCustomSpacing(8, after: keywordView)
            stackView.do {
                $0.layoutMargins.left = StackViewConstants.layoutVMargin
            }
            
            subKeywordLabel = keywordLabel
        }
    }
    
    private func setSearchBarAs(status: SearchStatus) {
        clearImageView.isHidden = searchTextField.text?.isEmpty == true && status != .editing
        searchImageView.isHidden = searchTextField.text?.isEmpty == false && status != .editing
        placeHolderLabel.isHidden = searchTextField.text?.isEmpty == false
    }
    
    // MARK: Rx Setup
    private func RX() {
        searchTextField.rx.controlEvent(.editingChanged).asSignal().emit(with: self) { owner, _ in
            owner.textFieldDidChange(owner.searchTextField)
        }.disposed(by: self.disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit).asSignal().emit(with: self) { owner, _ in
            owner.textFieldShouldReturn(owner.searchTextField)
        }.disposed(by: self.disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidBegin).asSignal().emit(with: self) { owner, _ in
            owner.textFieldEditingDidBegin(owner.searchTextField)
        }.disposed(by: self.disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEnd).asSignal().emit(with: self) { owner, _ in
            owner.textFieldEditingDidEnd(owner.searchTextField)
        }.disposed(by: self.disposeBag)
    }
}

// MARK: - Actions
extension DealiSearchInput {
    private func textFieldClearTapped() {
        guard searchTextField.text != nil, searchTextField.text?.isEmpty == false else { return }
        if resetKeywordWhenClearTapped {
            searchTextField.text = nil
            setSearchBarAs(status: searchTextField.isEditing ? .editing : .default)
        }
        delegate?.clear()
    }
    
    private func textFieldDidChange(_ textField: UITextField) {
        delegate?.editingChanged(keyword: textField.text)
        setSearchBarAs(status: .editing)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) {
        textField.resignFirstResponder()
        setSearchBarAs(status: .default)
        delegate?.search(keyword: textField.text)
    }
    
    private func textFieldEditingDidBegin(_ textField: UITextField) {
        if self.shouldUpdateStatusOnBeginEditing {
            setSearchBarAs(status: .editing)
        }
        delegate?.beginEditing()
    }
    
    private func textFieldEditingDidEnd(_ textField: UITextField) {
        setSearchBarAs(status: .default)
        delegate?.endEditing()
    }
    
    /// Public Search TextField Actions
     public func searchInputIsFirstResponder() {
        searchTextField.becomeFirstResponder()
    }
}
