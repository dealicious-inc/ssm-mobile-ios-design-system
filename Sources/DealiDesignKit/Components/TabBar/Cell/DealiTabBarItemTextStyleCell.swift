//
//  DealiTabBarItemTextStyleCell.swift
//
//
//  Created by 이창호 on 11/4/24.
//

import UIKit

/**
 설명 : 탭바 아이템 텍스트 스타일 셀
 */
final public class DealiTabBarItemTextStyleCell: DealiTabBarItemBaseCell {
    var uiModel: DealiTabBarItemTextStyleCellUIModel?
    
    private let titleLabel = UILabel()
    private let badgeImageView = UIImageView()
    private let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .gray
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.isUserInteractionEnabled = false
            $0.spacing = 0.0
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.iconImageView)
        self.iconImageView.then {
            $0.clipsToBounds = true
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
        
        contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.do {
            $0.clipsToBounds = true
        }
        
        self.addSubview(self.badgeImageView)
        self.badgeImageView.then {
            $0.backgroundColor = .primary01
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2.0
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(0.0)
            $0.bottom.equalTo(titleLabel.snp.top).offset(3.0)
            $0.size.equalTo(CGSize(width: 4.0, height: 4.0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemTextStyleCellUIModel?) {
        guard let uiModel = uiModel else { return }
        self.uiModel = uiModel
        
        self.titleLabel.text = uiModel.title
        self.titleLabel.textColor = uiModel.textColor
        self.titleLabel.font = uiModel.font
        
        self.badgeImageView.isHidden = !uiModel.shouldExposeNewBadge
        if let image = uiModel.iconURL, let size = uiModel.iconSize {
            self.iconImageView.setImage(url: image, size: size)
            self.iconImageView.isHidden = false
        } else {
            self.iconImageView.image = nil
            self.iconImageView.isHidden = true
        }
    }
}
