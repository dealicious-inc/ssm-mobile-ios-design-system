//
//  DealiTabBarItemButton.swift
//  
//
//  Created by Hoji on 3/29/24.
//

import UIKit

final class DealiTabBarItemButton: UIButton {

    var uiModel: DealiTabBarItemButtonUIModel?
    
    private let _titleLabel = UILabel()
    private let badgeImageView = UIImageView()
    private let iconImageView = UIImageView()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.alpha = 0.3
            } else {
                self.alpha = 1.0
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.isExclusiveTouch = true
        
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
        
        contentStackView.addArrangedSubview(self._titleLabel)
        self._titleLabel.do {
            $0.clipsToBounds = true
        }
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .clear
        config.background.backgroundColor = .clear
        self.configuration = config
        self.configurationUpdateHandler = { [weak self] in
            guard let self, let uiModel = self.uiModel else { return }
            switch $0.state {
            case .selected:
                self._titleLabel.font = uiModel.selectedFont
                self._titleLabel.textColor = uiModel.selectedTextColor
            default:
                self._titleLabel.font = uiModel.font
                self._titleLabel.textColor = uiModel.textColor
            }
        }
        
        self.addSubview(self.badgeImageView)
        self.badgeImageView.then {
            $0.backgroundColor = .primary01
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2.0
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.equalTo(self._titleLabel.snp.right).offset(0.0)
            $0.bottom.equalTo(self._titleLabel.snp.top).offset(3.0)
            $0.size.equalTo(CGSize(width: 4.0, height: 4.0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemButtonUIModel) {
        self.uiModel = uiModel
        
        self._titleLabel.text = uiModel.title
        self._titleLabel.textColor = (self.isSelected == true ? uiModel.selectedTextColor : uiModel.textColor)
        self._titleLabel.font = (self.isSelected == true ? uiModel.selectedFont : uiModel.font)
        
        self.badgeImageView.isHidden = !uiModel.shouldExposeNewBadge
        if let image = uiModel.iconURL, let size = uiModel.iconSize {
            self.iconImageView.setImage(url: image, size: size)
            self.iconImageView.isHidden = false
        }
    }

}

struct DealiTabBarItemButtonUIModel {
    /// 뉴 뱃지 노출 유무
    var shouldExposeNewBadge: Bool = false
    /// 버튼 타이틀
    var title: String?
    /// 기본 텍스트 컬러
    var textColor: UIColor = .g100
    /// 선택된 텍스트 컬러
    var selectedTextColor: UIColor = .g100
    /// 기본 텍스트 폰트
    var font: UIFont = .b2r14
    /// 선택된 텍스트 폰트
    var selectedFont: UIFont = .b2sb14
    /// 아이콘 URL
    var iconURL: URL?
    /// 아이콘 사이즈
    var iconSize: CGSize?
    
    static func make(preset: DealiTabBarPreset, tabbarItem: DealiTabBarItem) -> DealiTabBarItemButtonUIModel {
        var uiModel = DealiTabBarItemButtonUIModel()
        uiModel.title = tabbarItem.title
        uiModel.textColor = preset.textColor
        uiModel.selectedTextColor = preset.selectedTextColor
        uiModel.font = preset.font
        uiModel.selectedFont = preset.selectedFont
        uiModel.iconURL = tabbarItem.icon?.url
        uiModel.iconSize = tabbarItem.icon?.size
        uiModel.shouldExposeNewBadge = tabbarItem.showsBadge
        return uiModel
    }
}
