//
//  DealiTabBarItemImageChipStyleCell.swift
//  
//
//  Created by 이창호 on 12/2/24.
//

import UIKit

/**
    설명 : 탭바 아이템 이미지 칩 컴포넌트 스타일 셀
*/
final public class DealiTabBarItemImageChipStyleCell: DealiTabBarItemBaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectionStyle = .alpha
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemImageChipStyleCellUIModel?) {
        guard let uiModel = uiModel else { return }
        
        if let itemImageChip = uiModel.itemImageChip {
            self.contentView.addSubview(itemImageChip)
            itemImageChip.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
