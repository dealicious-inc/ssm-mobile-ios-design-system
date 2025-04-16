//
//  ComponentHeaderView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/16/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit

final class ComponentHeaderView: UICollectionReusableView {
    
    static let identifier = "ComponentHeaderView"
    
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.then {
            $0.font = .sh1sb20
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
