//
//  SearchBarCell.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/16/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class SearchBarCell: UICollectionViewCell {
    static let identifier = "SearchBarCell"
    
    lazy var searchInput = DealiSearchInput(delegate: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.searchInput)
        self.searchInput.then {
            $0.placeholder = "원하는 요소를 검색해주세요."
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBarCell: DealiSearchInputDelegate {
    func search(keyword: String?) {
        
    }
    
    func clear() {
        
    }
    
    func beginEditing() {
        
    }
    
    func endEditing() {
        self.resignFirstResponder()
    }
    
    func editingChanged(keyword: String?) {
        
    }
    
    
}
