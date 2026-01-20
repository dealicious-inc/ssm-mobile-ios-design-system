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

@MainActor
public protocol DealiSearchInputDelegate: AnyObject {
    func search(keyword: String?)
    func clear()
    func beginEditing()
    func endEditing()
    func editingChanged(keyword: String?)
}

@available(*, deprecated)
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
        static let placeholderColor: UIColor = .g60
        static let textColor: UIColor = .g100
        
        /// search image 관련 상수 모음
        static let imageSearch: UIImage? = UIImage.dealiIcon(named: "ic_search")
        static let imageClear: UIImage? = UIImage.dealiIcon(named: "ic_x_circle_filled")?.withTintColor(.g50)
        static let imageSearchSize: CGFloat = 24
        static let imageClearSize: CGFloat = 16
    }
    
    private enum StackViewConstants {
        /// StackView 관련 상수 모음
        static let radius: CGFloat = 6
        static let height: CGFloat = 40
        static let spacing: CGFloat = 16
        static let layoutHMargin: CGFloat = 16
        static let layoutVMargin: CGFloat = 6
    }
    
    private enum SubKeywordViewConsants {
        /// Sub Keyword View 관련 상수 모음
        static let maxWidth: CGFloat = 92
    }
    
    // MARK: - Variables
    private let stackView = UIStackView()
    private let placeHolderLabel = UILabel()
    private let searchTextField = UITextField()
    private let clearImageView = UIImageView()
    private let searchImageView = UIImageView()
    private var subKeywordTag: DealiTag?
    private var inputType: SearchInputType = .default {
        didSet {
            self.updateKeyword(keyword)
        }
    }
    public weak var delegate: DealiSearchInputDelegate?
    private let disposeBag = DisposeBag()
    
    /// SearchInput preset 스타일
    public var preset: DealiSearchInputPreset = .searchInput02 {
        didSet {
            updatePresetStyle()
            // subKeyword가 있는 경우 스타일도 업데이트
            if subKeywordTag != nil {
                updateSubKeywordStyle()
            }
        }
    }
    
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
    
    /// 키보드 닫기 String을 받을경우에만 해당 버튼이 추가되도록 작업
    public var keyboardCloseButtonString: String? {
        didSet {
            guard let keyboardCloseButtonString = self.keyboardCloseButtonString else { return }
            
            let keyboardAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44.0))
            keyboardAccessoryView.do {
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
            
            self.searchTextField.inputAccessoryView = keyboardAccessoryView
            
            keyboardCloseButton.rx.tap.subscribe(with: self) { owner, _ in
                owner.searchTextField.endEditing(true)
            }.disposed(by: self.disposeBag)
        }
    }
    
    // MARK: - Initializer
    public init(
        keyword: String = "",
        placeholder: String = "",
        preset: DealiSearchInputPreset = .searchInput02,
        delegate: DealiSearchInputDelegate?
    ) {
        super.init(frame: .zero)
        self.preset = preset
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
        updatePresetStyle()
    }
    
    private func updatePresetStyle() {
        stackView.backgroundColor = preset.backgroundColor
        if preset.hasBorder {
            stackView.setCornerRadius(
                StackViewConstants.radius,
                borderWidth: preset.borderWidth,
                borderColor: preset.borderColor
            )
        } else {
            stackView.setCornerRadius(StackViewConstants.radius)
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
            $0.isUserInteractionEnabled = true
            $0.image = Constants.imageSearch
        }.snp.makeConstraints {
            $0.width.equalTo(Constants.imageSearchSize)
        }
        
        searchImageView.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.textFieldShouldReturn(self.searchTextField)
            })
            .disposed(by: self.disposeBag)
        
        clearImageView.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.textFieldClearTapped()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setSubKeywordView(with keyword: String) {
        if let subKeywordTag {
            subKeywordTag.text = keyword
            updateSubKeywordStyle()
        } else {
            let keywordTag = DealiTag()
            stackView.insertArrangedSubview(keywordTag, at: 0)
            keywordTag.then {
                $0.text = keyword
                $0.type = currentSubKeywordTagType
                $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            }.snp.makeConstraints {
                $0.width.lessThanOrEqualTo(SubKeywordViewConsants.maxWidth)
            }
            
            stackView.setCustomSpacing(8, after: keywordTag)
            stackView.do {
                $0.layoutMargins.left = StackViewConstants.layoutVMargin
            }
            
            subKeywordTag = keywordTag
            updateSubKeywordStyle()
        }
    }
    
    private func updateSubKeywordStyle() {
        guard let subKeywordTag = subKeywordTag else { return }
        subKeywordTag.type = currentSubKeywordTagType
    }

    private var currentSubKeywordTagType: DealiTag.EType {
        switch preset {
        case .searchInput01:
            return .tagFilledLarge04
        case .searchInput02:
            return .tagOutlineLarge04
        }
    }
    
    private func setSearchBarAs(status: SearchStatus) {
        clearImageView.isHidden = searchTextField.text?.isEmpty == true
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
        setSearchBarAs(status: .editing)
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
