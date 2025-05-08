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
    @State private var text: String = "텍스트 입력 중"
    @State private var isFocused: Bool = false

    var body: some View {
        DLSearchInput(
            text: $text,
            isFocused: $isFocused,
            placeholder: "상품을 검색해주세요"
        )
    }
}

#Preview {
    SearchInputTestView()
}
