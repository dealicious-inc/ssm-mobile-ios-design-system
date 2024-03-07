//
//  File.swift
//  
//
//  Created by JohyeonYoon on 3/7/24.
//

import UIKit
import RxSwift
import RxCocoa

struct DealiBottomSheetMultiSelectCellUIModel {
    var optionName: String?
    var isSelected: Bool = false
    
    var optionFont: UIFont {
        self.isSelected ? .b1sb15 : .b1r15
    }
    
    var optionTextColor: UIColor {
        self.isSelected ? DealiColor.primary01 : DealiColor.g100
    }
    
    var selectedActionHandler: (() -> Void)?
    
    static func map(optionData: DealiBottomSheetOptionData) -> DealiBottomSheetMultiSelectCellUIModel {
        return DealiBottomSheetMultiSelectCellUIModel(optionName: optionData.optionName, isSelected: optionData.isSelected)
    }
}

final class DealiBottomSheetMultiSelectCell: UICollectionViewCell {
    
    private let checkbox = DealiCheckbox()
    private let optionLabel = UILabel()
    private var disposeBag = DisposeBag()
    
    static func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 52.0)
    }
    
    static let id = "DealiBottomSheetMultiSelectCell"
    
    func configure(with uiModel: DealiBottomSheetMultiSelectCellUIModel?) {
        guard let uiModel else { return }
        self.optionLabel.text = uiModel.optionName
        self.optionLabel.font = uiModel.optionFont
        self.optionLabel.textColor = uiModel.optionTextColor
        self.checkbox.isSelected = uiModel.isSelected
        
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
        
        self.contentView.addSubview(self.checkbox)
        self.checkbox.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16.0)
        }
        
        self.contentView.addSubview(self.optionLabel)
        self.optionLabel.then {
            $0.font = .b1r15
            $0.textColor = DealiColor.g100
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.checkbox.snp.right).offset(12.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
