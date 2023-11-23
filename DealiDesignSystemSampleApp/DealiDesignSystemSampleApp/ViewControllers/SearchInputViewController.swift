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
        
        let searchBarView1 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarView1)
        searchBarView1.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarView2 = DealiSearchInput(defaultKeyword: "원피스", placeholderText: "상품을 검색해주세요.", delegate: self)
        contentStackView.addArrangedSubview(searchBarView2)
        searchBarView2.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarView3 = DealiSearchInput(defaultKeyword: "원피스", placeholderText: "상품을 검색해주세요.", resetKeywordWhenClearTapped: false, delegate: self)
        contentStackView.addArrangedSubview(searchBarView3)
        searchBarView3.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchBarView3.updateKeyword("키워드 변경")
        
        let searchBarView4 = DealiSearchInput(placeholderText: "상품을 검색해주세요.", delegate: self)
        contentStackView.addArrangedSubview(searchBarView4)
        searchBarView4.then {
            $0.backgroundColor = .clear
            $0.keyboardCloseButtonString = "닫기"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView1 = DealiSearchInput(type: .subCategory(keyword: "아우터"), delegate: self)
        contentStackView.addArrangedSubview(searchBarSubCategoryView1)
        searchBarSubCategoryView1.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView2 = DealiSearchInput(type: .subCategory(keyword: "아우터"), defaultKeyword: "패딩", delegate: self)
        contentStackView.addArrangedSubview(searchBarSubCategoryView2)
        searchBarSubCategoryView2.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView3 = DealiSearchInput(
            type: .subCategory(keyword: "키워드가 들어가는데 엄청길어요")
            , placeholderText: "상품을 검색해주세요."
            , delegate: self
        )
        contentStackView.addArrangedSubview(searchBarSubCategoryView3)
        searchBarSubCategoryView3.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

extension SearchInputViewController: DealiSearchInputDelegate {
    func endEditing() {
        
    }
    
    func search(keyword: String?) {
        guard let keyword = keyword else {
            print("nil")
            return
        }
        print(keyword)
    }
    
    func clear() {
        print("clear !")
    }
    
    func beginEditing() {
        print("begin Editing !")
    }
    
    func editingChanged(keyword: String?) {
        
    }
}
