//
//  SearchInputViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2023/11/09.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class SearchInputViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "DealiSearchInput"
        self.view.backgroundColor = .white
        
        
    }
    
    override func loadView() {
        super.loadView()
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }

        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let contentStackView = UIStackView()
        contentScrollView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        
        
        let searchBarView = DealiSearchInput()
        contentStackView.addArrangedSubview(searchBarView)
        searchBarView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarPlaceHolderView = DealiSearchInput(placeholderText: "상품을 검색해주세요.")
        contentStackView.addArrangedSubview(searchBarPlaceHolderView)
        searchBarPlaceHolderView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView = DealiSearchInput()
        contentStackView.addArrangedSubview(searchBarSubCategoryView)
        searchBarSubCategoryView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        searchBarSubCategoryView.setSubCategoryView(with: "아우터")
        
        let searchBarSubCategoryLongView = DealiSearchInput()
        contentStackView.addArrangedSubview(searchBarSubCategoryLongView)
        searchBarSubCategoryLongView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        searchBarSubCategoryLongView.setSubCategoryView(with: "키워드가 들어가는데 엄청길어요")
    }

    

}
