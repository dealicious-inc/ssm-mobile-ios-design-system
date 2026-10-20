//
//  SearchInputViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2023/11/09.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit
import Combine

final class SearchInputViewController: UIViewController {
    
    var isSwiftUI: Bool = false
    var detachBag: AnyDetachBag = .init()
    
    var cancellables = Set<AnyCancellable>()
    
    var swiftUIViewModel: SearchInputViewModel = .init(text: "텍스트 입력 중", isFocused: false)
    
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
        
        // MARK: - searchInput01 예제
        let searchInput01Label = UILabel().then {
            $0.text = "searchInput01 (흰색 배경, 테두리)"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .g100
        }

        contentStackView.addArrangedSubview(searchInput01Label)
        searchInput01Label.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let searchInput01View = DealiSearchInput(preset: .searchInput01, delegate: self)
        contentStackView.addArrangedSubview(searchInput01View)
        searchInput01View.then {
            $0.backgroundColor = .clear
            $0.placeholder = "상품을 검색해주세요."
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        // searchInput01 with subKeyword 예제
        let searchInput01WithTagView = DealiSearchInput(preset: .searchInput01, delegate: self)
        contentStackView.addArrangedSubview(searchInput01WithTagView)
        searchInput01WithTagView.then {
            $0.backgroundColor = .clear
            $0.placeholder = "상품을 검색해주세요."
            $0.subKeyword = "원피스"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }

        let searchInput01WithLongTagView = DealiSearchInput(preset: .searchInput01, delegate: self)
        contentStackView.addArrangedSubview(searchInput01WithLongTagView)
        searchInput01WithLongTagView.then {
            $0.backgroundColor = .clear
            $0.placeholder = "상품을 검색해주세요."
            $0.subKeyword = "T-shirts 긴키워드입니다"
            $0.keyword = "긴 글자 keyword 검색 시"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        // MARK: - searchInput02 예제 (기존)
        let searchInput02Label = UILabel().then {
            $0.text = "searchInput02 (회색 배경, 테두리 없음)"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .g100
        }
        contentStackView.addArrangedSubview(searchInput02Label)
        searchInput02Label.snp.makeConstraints {
            $0.left.right.equalToSuperview()
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
       
        let searchInput =  SearchInput(
            viewModel: self.swiftUIViewModel,
            onClear: {
                debugPrint("클리어 클릭")
            },
            onSearch: { text in
                debugPrint("검색 클릭. 검색어: \(text)")
            }
        )
        
        let searchInputView = DealiSwiftUIWrapperView(rootView: searchInput)
        contentStackView.addArrangedSubview(searchInputView)
        self.swiftUIViewModel.placeholder = "검색어를 입력하세요."
        
        self.swiftUIViewModel.$isFocused
            .removeDuplicates()
            .sink { isFocused in
                if isFocused {
                    debugPrint("포커스 인")
                } else {
                    debugPrint("포커스 아웃")
                }
            }
            .store(in: &self.cancellables)
        
        self.swiftUIViewModel.$text
            .removeDuplicates()
            .sink { text in
                debugPrint("문구: \(text)")
            }
            .store(in: &self.cancellables)
        
        searchInputView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
            
        return contentStackView
    }
}
