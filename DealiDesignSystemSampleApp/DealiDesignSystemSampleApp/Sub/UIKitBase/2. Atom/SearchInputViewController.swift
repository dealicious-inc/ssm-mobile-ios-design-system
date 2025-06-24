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
    
    var isSwiftUI: Bool = false
    var detachBag: AnyDetachBag = .init()
    
    var swiftUIViewModel: DLSearchInputViewModel = .init(text: "텍스트 입력 중", isFocused: false)
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "DealiSearchInput"
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        
        self.setUI()
    }
    
    func setUI() {
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        let contentStackView: UIStackView = {
            if self.isSwiftUI {
                return self.swiftUIView()
            } else {
                return self.uikitView()
            }
        }()
        
        contentScrollView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
    }
}

// MARK: - UIKit
extension SearchInputViewController {
    func uikitView() -> UIStackView {
        let contentStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
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
        
        return contentStackView
    }
}
extension SearchInputViewController: DealiSearchInputDelegate {
    func endEditing() {
        
    }
    
    func search(keyword: String?) {
        guard let keyword = keyword else {
            debugPrint("nil")
            return
        }
        debugPrint(keyword)
    }
    
    func clear() {
        debugPrint("clear !")
    }
    
    func beginEditing() {
        debugPrint("begin Editing !")
    }
    
    func editingChanged(keyword: String?) {
        
    }
}

import SwiftUI

// MARK: - SwiftUI
extension SearchInputViewController {
   
    func swiftUIView() -> UIStackView {
        let contentStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
       
        let result =  DLSearchInput(
            viewModel: self.swiftUIViewModel,
            placeholder: "상품을 검색해주세요",
            onSearch: {
                debugPrint("검색 클릭. 검색어: \(self.swiftUIViewModel.text)")
            }
        ).toUIView(embeddedIn: self)
        
        self.detachBag.add(result)
        
        let view = result.view
        contentStackView.addArrangedSubview(view)
        
        view.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
            
        return contentStackView
    }
}
