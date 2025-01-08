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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectionStyle = .alpha
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemChipStyleCellUIModel?) {
        guard let uiModel = uiModel else { return }
        
        if let itemChip = uiModel.itemChip {
            self.contentView.addSubview(itemChip)
            itemChip.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
