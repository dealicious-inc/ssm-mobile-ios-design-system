//
//  DealiBottomSheetIconWithTextCell.swift
//
//
//  Created by JohyeonYoon on 3/7/24.
//

import UIKit
import RxSwift
import RxCocoa

struct DealiBottomSheetIconWithTextCellUIModel {
    var optionName: String?
    var isSelected: Bool = false
    var iconImageName: String?
    
    var optionFont: UIFont {
        self.isSelected ? .b1sb15 : .b1r15
    }
    
    var optionTextColor: UIColor {
        self.isSelected ? DealiColor.primary01 : DealiColor.g100
    }
    
    var isCheckIconHidden: Bool {
        !self.isSelected
    }
    
    var selectedActionHandler: (() -> Void)?
    
    static func map(optionData: DealiBottomSheetOptionData) -> DealiBottomSheetIconWithTextCellUIModel {
        return DealiBottomSheetIconWithTextCellUIModel(optionName: optionData.optionName, isSelected: optionData.isSelected, iconImageName: optionData.imageName)
    }
}

final class DealiBottomSheetIconWithTextCell: UICollectionViewCell {
    
    private let iconImageView = UIImageView()
    private let optionLabel = UILabel()
    private let checkIconImageView = UIImageView()
    
    private var disposeBag = DisposeBag()
    
    static func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 52.0)
    }
    
    static let id = "DealiBottomSheetIconWithTextCell"
    
    func configure(with uiModel: DealiBottomSheetIconWithTextCellUIModel?) {
        guard let uiModel else { return }
        self.optionLabel.text = uiModel.optionName
        self.optionLabel.font = uiModel.optionFont
        self.optionLabel.textColor = uiModel.optionTextColor
        self.checkIconImageView.isHidden = uiModel.isCheckIconHidden
        
        if let iconImageName = uiModel.iconImageName {
            self.iconImageView.image = UIImage(named: iconImageName, in: Bundle.module, compatibleWith: nil)
        }
        
        self.contentView.rx.tapGestureOnTop()
            .when(.recognized)
            .bind { _ in
                uiModel.selectedActionHandler?()
            }
            .disposed(by: self.disposeBag)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.left.equalToSuperview().inset(16.0)
        }
        
        self.contentView.addSubview(self.optionLabel)
        self.optionLabel.then {
            $0.font = .b1r15
            $0.textColor = DealiColor.g100
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.iconImageView.snp.right).offset(12.0)
        }
        
        self.contentView.addSubview(self.checkIconImageView)
        self.checkIconImageView.then {
            $0.isHidden = true
            $0.image = UIImage(named: "ic_check", in: Bundle.module, compatibleWith: nil)?.withTintColor(DealiColor.primary01)

        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16.0)
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
