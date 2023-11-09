//
//  File.swift
//  
//
//  Created by 조서현 on 2023/11/09.
//

import UIKit

public final class DealiSearchInput: UIView {
    
    private enum Constants {
        // search textfield
        static let font: UIFont = .systemFont(ofSize: 14)
        static let placeholderColor: UIColor = DealiColor.g60
        static let textColor: UIColor = DealiColor.g100
        
        // search image
        static let imageSearch: UIImage = UIImage(named: "ic_search")!
        static let imageClear: UIImage = UIImage(named: "ic_x")!
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
    
    public convenience init(placeholderText: String = "") {
        self.init(frame: .zero)
        setPlaceHolder(text: placeholderText)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private setUI function
    private func configure(placeholder: String = "") {
        setContainerStackView()
        setTextField()
        setSearchStatusImage()
    }
    
    private func setContainerStackView() {
        addSubview(stackView)
        stackView.then {
            $0.backgroundColor = StackViewConstants.backgroundColor
            $0.setCornerRadius(StackViewConstants.radius)
            $0.spacing = StackViewConstants.spacing
            $0.alignment = .center
            $0.distribution = .equalSpacing
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
        
//        let placeHolderLabel = UILabel()
        textInputContainer.addSubview(placeHolderLabel)
        placeHolderLabel.then {
            $0.textColor = Constants.placeholderColor
            $0.font = Constants.font
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // TODO: @조서현 placeholderLabel에 textfield editing 관련 hidden 조건 action으로 걸어놓을것
        
        let textField = UITextField()
        textInputContainer.addSubview(textField)
        textField.then {
            $0.textColor = Constants.textColor
            $0.font = Constants.font
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .clear
//            $0.delegate = self
            // TODO: @조서현 delegate 로 이벤트 받아서 이미지 변경 또는 clear처리 필요, search or clear시점에 action 추가 필요
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // TODO: @조서현 textfield editing action 추가 필요
        
    }
    
    private func setSearchStatusImage() {
        let imageView = UIImageView()
        stackView.addArrangedSubview(imageView)
        imageView.then {
            $0.image = Constants.imageSearch
        }.snp.makeConstraints {
            $0.width.height.equalTo(Constants.imageSize)
        }
        
        // TODO: @조서현 textfield 상태에 따라서 이미지 변경되어야 함
    }
    
    private func setPlaceHolder(text: String) {
        placeHolderLabel.text = text
    }
    
    
    // MARK: - public function
    public func setSubCategoryView(with keyword: String) {
        let keywordView = UIView()
        stackView.insertArrangedSubview(keywordView, at: 0)
        keywordView.then {
            $0.backgroundColor = SubCategoryConsants.backgroundColor
            $0.setCornerRadius(
                SubCategoryConsants.radius
                , borderWidth: SubCategoryConsants.borderWidth
                , borderColor: SubCategoryConsants.borderColor
            )
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
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
        
        
        // TODO: @조서현 search 이미지는 미노출되도록 수정 필요
    }
    
}

extension UIView {
    func setCornerRadius(_ radius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor? = .clear) {
        if let _ = borderColor {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
