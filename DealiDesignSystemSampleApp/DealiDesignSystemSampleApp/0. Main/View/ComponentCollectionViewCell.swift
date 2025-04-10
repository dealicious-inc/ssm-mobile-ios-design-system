//
//  ComponentCollectionViewCell.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/10/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class ComponentCollectionViewCell: UICollectionViewCell {
    static let identifier = "ComponentCollectionViewCell"
    
    private let button = DealiControl.btnFilledTonalLarge01()
    
    func configure(_ item: ItemData) {
        self.button.title = item.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.button)
        self.button.then {
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
