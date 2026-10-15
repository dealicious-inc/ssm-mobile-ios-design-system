//
//  DealiTabBarItemCustomStyleCell.swift
//
//
//  Created by 이창호 on 10/8/26.
//

import UIKit

/**
 설명: 탭바 아이템 커스텀 뷰 스타일 셀. 앱이 넘긴 `DealiTabBarCustomItemView`를 가운데 배치한다.
 */
final public class DealiTabBarItemCustomStyleCell: DealiTabBarItemBaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectionStyle = .alpha
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemCustomStyleCellUIModel?) {
        guard let uiModel = uiModel else { return }
        
        if let itemView = uiModel.itemView {
            self.contentView.addSubview(itemView)
            itemView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
