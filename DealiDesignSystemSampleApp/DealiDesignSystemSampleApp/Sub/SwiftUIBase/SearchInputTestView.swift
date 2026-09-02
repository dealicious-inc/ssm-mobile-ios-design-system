//
//  SearchInputTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 4/1/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct SearchInputTestView: View {
    @StateObject private var viewModel01 = SearchInputViewModel(text: "", isFocused: false, preset: .searchInput01)
    @StateObject private var viewModel02 = SearchInputViewModel(text: "텍스트 입력 중", isFocused: false, preset: .searchInput02)
    @StateObject private var viewModel01WithKeyword = SearchInputViewModel(text: "긴 글자 keyword 검색 시", keyword: "원피스", preset: .searchInput01)
    @StateObject private var viewModel02WithKeyword = SearchInputViewModel(text: "키워드 있을 때", keyword: "아우터", preset: .searchInput02)

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // searchInput01 예제
                VStack(alignment: .leading, spacing: 12) {
                    Text("searchInput01 (흰색 배경, 테두리)")
                        .font(.headline)
                    
                    SearchInput(
                        viewModel: viewModel01,
                        onClear: {
                            print("Clear tapped")
                        },
                        onSearch: { text in
                            print("Search: \(text)")
                        }
                    )
                    
                    SearchInput(
                        viewModel: viewModel01WithKeyword,
                        onClear: {
                            print("Clear tapped")
                        },
                        onSearch: { text in
                            print("Search: \(text)")
                        }
                    )
                }
                
                // searchInput02 예제
                VStack(alignment: .leading, spacing: 12) {
                    Text("searchInput02 (회색 배경, 테두리 없음)")
                        .font(.headline)
                    
                    SearchInput(
                        viewModel: viewModel02,
                        onClear: {
                            print("Clear tapped")
                        },
                        onSearch: { text in
                            print("Search: \(text)")
                        }
                    )
                    
                    SearchInput(
                        viewModel: viewModel02WithKeyword,
                        onClear: {
                            print("Clear tapped")
                        },
                        onSearch: { text in
                            print("Search: \(text)")
                        }
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    SearchInputTestView()
}
