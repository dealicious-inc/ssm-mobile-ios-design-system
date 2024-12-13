//
//  DealiTabBarItemCustomStyleCell.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 12/13/24.
//

import UIKit

/**
    설명 : 탭바 아이템 CustomView 스타일 셀
*/
final public class DealiTabBarItemCustomStyleCell: DealiTabBarItemBaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(uiModel: DealiTabBarItemCustomStyleCellUIModel?) {
        guard let uiModel = uiModel else { return }
        
        if let customView = uiModel.customView {
            self.addSubview(customView)
            customView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
