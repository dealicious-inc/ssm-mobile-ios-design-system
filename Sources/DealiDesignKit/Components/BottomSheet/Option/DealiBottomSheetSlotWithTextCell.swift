//
//  DealiBottomSheetSlotWithTextCell.swift
//
//
//  Created by JohyeonYoon on 3/7/24.
//

import UIKit
import RxSwift
import RxCocoa

struct DealiBottomSheetSlotWithTextCellUIModel {
    var optionName: String?
    var isSelected: Bool = false
    var slotImageName: String?
    var slotSize: CGSize?
    
    var optionFont: UIFont {
        self.isSelected ? .b1sb15 : .b1r15
    }
    
    var optionTextColor: UIColor {
        self.isSelected ? .primary01 : .g100
    }
    
    var isCheckIconHidden: Bool {
        !self.isSelected
    }
    
    var selectedActionHandler: (() -> Void)?
    
    static func map(optionData: DealiBottomSheetOptionData, slotSize: CGSize) -> DealiBottomSheetSlotWithTextCellUIModel {
        return DealiBottomSheetSlotWithTextCellUIModel(optionName: optionData.optionName, isSelected: optionData.isSelected, slotImageName: optionData.imageName, slotSize: slotSize)
    }
}

final class DealiBottomSheetSlotWithTextCell: UICollectionViewCell {
    
    private let slotImageView = UIImageView()
    private let optionLabel = UILabel()
    private let checkIconImageView = UIImageView()
    
    private var disposeBag = DisposeBag()
    
    static func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 52.0)
    }
    
    static let id = "DealiBottomSheetSlotWithTextCell"
    
    func configure(with uiModel: DealiBottomSheetSlotWithTextCellUIModel?) {
        guard let uiModel else { return }
        self.optionLabel.text = uiModel.optionName
        self.optionLabel.font = uiModel.optionFont
        self.optionLabel.textColor = uiModel.optionTextColor
        self.checkIconImageView.isHidden = uiModel.isCheckIconHidden
        
        if let slotImageName = uiModel.slotImageName, let slotSize = uiModel.slotSize {
            self.slotImageView.then {
                $0.image = UIImage(named: slotImageName, in: Bundle.module, compatibleWith: nil)
            }.snp.updateConstraints {
                $0.size.equalTo(slotSize)
            }
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
        
        self.contentView.addSubview(self.slotImageView)
        self.slotImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.left.equalToSuperview().inset(16.0)
        }
        
        self.contentView.addSubview(self.optionLabel)
        self.optionLabel.then {
            $0.font = .b1r15
            $0.textColor = .g100
        }.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.slotImageView.snp.right).offset(12.0)
        }
        
        self.contentView.addSubview(self.checkIconImageView)
        self.checkIconImageView.then {
            $0.isHidden = true
            $0.image = UIImage(named: "ic_check", in: Bundle.module, compatibleWith: nil)?.withTintColor(.primary01)

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
