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
        
        let searchBarView2 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarView2)
        searchBarView2.then {
            $0.keyword = "원피스"
            $0.placeholder = "상품을 검색해주세요."
            $0.shouldUpdateStatusOnBeginEditing = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarView3 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarView3)
        searchBarView3.then {
            $0.keyword = "원피스"
            $0.placeholder = "상품을 검색해주세요."
            $0.resetKeywordWhenClearTapped = false
            $0.shouldUpdateStatusOnBeginEditing = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchBarView3.updateKeyword("clear 버튼 disable 기능 테스트")
        
        let searchBarView4 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarView4)
        searchBarView4.then {
            $0.backgroundColor = .clear
            $0.placeholder = "keyboard AccessoryView test"
            $0.keyboardCloseButtonString = "닫기"
            $0.shouldUpdateStatusOnBeginEditing = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView1 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarSubCategoryView1)
        searchBarSubCategoryView1.then {
            $0.backgroundColor = .clear
            $0.subKeyword = "아우터"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView2 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarSubCategoryView2)
        searchBarSubCategoryView2.then {
            $0.backgroundColor = .clear
            $0.keyword = "패딩"
            $0.subKeyword = "신발상가 A동"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        let searchBarSubCategoryView3 = DealiSearchInput(delegate: self)
        contentStackView.addArrangedSubview(searchBarSubCategoryView3)
        searchBarSubCategoryView3.then {
            $0.subKeyword = "abcdefghijk"
            $0.placeholder = "상품을 검색해주세요."
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchBarSubCategoryView3.updateSubKeyword("ChangeKeyword")
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
