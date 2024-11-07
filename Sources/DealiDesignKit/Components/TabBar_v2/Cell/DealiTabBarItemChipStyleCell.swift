//
//  DealiTabBarItemChipStyleCell.swift
//  
//
//  Created by 이창호 on 11/4/24.
//

import UIKit

/**
    설명 : 탭바 아이템 칩 컴포넌트 스타일 셀
*/
final public class DealiTabBarItemChipStyleCell: DealiTabBarItemBaseCell {
    
    private var chipButton: ClickableComponentChip?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(itemInfo: DealiTabBarItemInfo_v2) {
        guard let itemChip = itemInfo.itemChip else { return }
        
        self.chipButton?.removeFromSuperview()
        
        self.chipButton = itemChip
        if let chipButton = self.chipButton {
            self.addSubview(chipButton)
            chipButton.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
        
    }
}
