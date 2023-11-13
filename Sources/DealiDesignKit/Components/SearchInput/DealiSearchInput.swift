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
}

public final class DealiSearchInput: UIView {
    
    public enum SeachInputType {
        case `default`
        case subCategory(keyword: String)
    }
    
    private enum SearchStatus {
        case empty
        case editing
        
        var image: UIImage? {
            switch self {
            case .empty: return Constants.imageSearch
            case .editing: return Constants.imageClear
            }
        }
    }
    
    private enum Constants {
        // search textfield
        static let font: UIFont = .systemFont(ofSize: 14)
        static let placeholderColor: UIColor = DealiColor.g60
        static let textColor: UIColor = DealiColor.g100
        
        // search image
        static let imageSearch: UIImage? = UIImage(named: "ic_search")
        static let imageClear: UIImage? = UIImage(named: "ic_x")
        static let imageSize: CGFloat = 16
    }
    
    private enum StackViewConstants {
        static let radius: CGFloat = 6
        static let height: CGFloat = 40
        static let backgroundColor: UIColor = DealiColor.g10
        static let spacing: CGFloat = 16
        static let layoutHMargin: CGFloat = 16
        static let layoutVMargin: CGFloat = 6
    }
    
    private enum SubCategoryConsants {
        static let backgroundColor: UIColor = DealiColor.primary04
        static let radius: CGFloat = 6
        static let borderColor: UIColor = DealiColor.g20
        static let borderWidth: CGFloat = 1
        static let maxWidth: CGFloat = 80
        static let textColor: UIColor = DealiColor.g80
        static let font: UIFont = .systemFont(ofSize: 14, weight: .bold)
    }
    
    private let stackView = UIStackView()
    private let placeHolderLabel = UILabel()
    private let searchTextField = UITextField()
    private let searchImageView = UIImageView()
    
    private var inputType: SeachInputType = .default
    private weak var delegate: DealiSearchInputDelegate?
    private var resetKeywordWhenClearTapped: Bool = true
    
    private let disposeBag = DisposeBag()
    
    public init(type: SeachInputType = .default
                , defaultKeyword: String = ""
                , placeholderText: String = ""
                , resetKeywordWhenClearTapped: Bool = true
                , delegate: DealiSearchInputDelegate? = nil) {
        self.delegate = delegate
        self.inputType = type
        self.resetKeywordWhenClearTapped = resetKeywordWhenClearTapped
        
        super.init(frame: .zero)
        
        configure(keyword: defaultKeyword, placeholder: placeholderText)
        
        switch type {
        case .subCategory(let keyword):
            setSubCategoryView(with: keyword)
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(keyword: String, placeholder: String) {
        setContainerStackView()
        setTextField(keyword: keyword, placeholder: placeholder)
        setSearchStatusImage(hasDefaultKeyboard: !keyword.isEmpty)
    }
    
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
    
    private func setTextField(keyword: String, placeholder: String) {
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
            $0.text = placeholder
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
            $0.text = keyword
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        RX()
    }
    
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
    }
    
    private func setSearchStatusImage(hasDefaultKeyboard: Bool) {
        stackView.addArrangedSubview(searchImageView)
        searchImageView.then {
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = true
        }.snp.makeConstraints {
            $0.width.height.equalTo(Constants.imageSize)
        }
        setSearchBarAs(status: hasDefaultKeyboard ? .editing : .empty)
        
        searchImageView.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.textFieldClearTapped()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setSubCategoryView(with keyword: String) {
        let keywordView = UIView()
        stackView.insertArrangedSubview(keywordView, at: 0)
        keywordView.then {
            $0.backgroundColor = SubCategoryConsants.backgroundColor
            $0.setCornerRadius(
                SubCategoryConsants.radius
                , borderWidth: SubCategoryConsants.borderWidth
                , borderColor: SubCategoryConsants.borderColor
            )
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(SubCategoryConsants.maxWidth)
        }
        
        let keywordLabel = UILabel()
        keywordView.addSubview(keywordLabel)
        keywordLabel.then {
            $0.textColor = SubCategoryConsants.textColor
            $0.font = SubCategoryConsants.font
            $0.textAlignment = .center
            $0.lineBreakMode = .byTruncatingTail
            $0.text = keyword
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
        
        stackView.setCustomSpacing(8, after: keywordView)
    }
    
    private func setSearchBarAs(status: SearchStatus) {
        switch inputType {
        case .default:
            searchImageView.image = status.image
        case .subCategory:
            switch status {
            case .empty:
                searchImageView.image = nil
            case .editing:
                searchImageView.image = status.image
            }
        }
        placeHolderLabel.isHidden = (status == .editing || searchTextField.text?.isEmpty == false)
    }
}

// MARK: - Actions
extension DealiSearchInput {
    private func textFieldClearTapped() {
        guard searchTextField.text != nil else { return }
        if resetKeywordWhenClearTapped {
            searchTextField.text = nil
            setSearchBarAs(status: .empty)
        }
        delegate?.clear()
    }
    
    private func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            setSearchBarAs(status: .empty)
            return
        }
        setSearchBarAs(status: .editing)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) {
        textField.resignFirstResponder()
        delegate?.search(keyword: textField.text)
    }
    
    private func textFieldEditingDidBegin(_ textField: UITextField) {
        delegate?.beginEditing()
    }
    
}
