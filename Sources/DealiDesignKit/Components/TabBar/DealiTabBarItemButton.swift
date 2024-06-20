//
//  DealiTabBarItemButton.swift
//  
//
//  Created by Hoji on 3/29/24.
//

import UIKit

final class DealiTabBarItemButton: UIButton {

    var uiModel: DealiTabBarItemButtonUIModel?
    
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
        
        self.addSubview(self.badgeImageView)
        self.badgeImageView.then {
            $0.backgroundColor = DealiColor.primary01
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2.0
            $0.isHidden = true
        }.snp.makeConstraints {
            guard let titleLabel = titleLabel else {return}
            $0.left.equalTo(titleLabel.snp.right).offset(0.0)
            $0.bottom.equalTo(titleLabel.snp.top).offset(3.0)
            $0.size.equalTo(CGSize(width: 4.0, height: 4.0))
        }
        
        self.addSubview(self.iconImageView)
        self.iconImageView.then {
            $0.clipsToBounds = true
            $0.isHidden = true
        }.snp.makeConstraints {
            guard let titleLabel = titleLabel else { return }
            $0.right.equalTo(titleLabel.snp.left)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemButtonUIModel) {
        self.uiModel = uiModel
        
        self.setTitle(uiModel.title, for: .normal)
        self.setTitleColor(uiModel.textColor, for: .normal)
        self.setTitleColor(uiModel.selectedTextColor, for: .selected)
         
        self.titleLabel?.font = (self.isSelected == true ? uiModel.selectedFont : uiModel.font)
        
        self.badgeImageView.isHidden = !uiModel.shouldExposeNewBadge
        if let image = uiModel.iconURL, let size = uiModel.iconSize {
            self.iconImageView.setImage(url: image, size: size)
            self.iconImageView.isHidden = false
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if let uiModel = self.uiModel {
                self.titleLabel?.font = (self.isSelected == true ? uiModel.selectedFont : uiModel.font)
            }
        }
    }

}

struct DealiTabBarItemButtonUIModel {
    /// 뉴 뱃지 노출 유무
    var shouldExposeNewBadge: Bool = false
    /// 버튼 타이틀
    var title: String?
    /// 기본 텍스트 컬러
    var textColor: UIColor = DealiColor.g100
    /// 선택된 텍스트 컬러
    var selectedTextColor: UIColor = DealiColor.g100
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
