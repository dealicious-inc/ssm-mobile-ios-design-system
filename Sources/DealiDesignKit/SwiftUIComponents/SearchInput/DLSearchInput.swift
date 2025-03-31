//
//  DLSearchInput.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/31/25.
//

import SwiftUI

struct DLSearchInput: View {
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    var placeholder: String = "상품을 검색해주세요."
    
    var body: some View {
        HStack(spacing: 16.0) {
            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundColor(Color(uiColor: .g60))
                    .font((Font(UIFont.b2r14)))
            )
            .font(Font(UIFont.b2r14))
            .foregroundStyle(Color(uiColor: .g100))
            .focused($isFocused)
            .disableAutocorrection(true)

            
            Image.dealiIcon(named: "ic_search")
        }
        .padding(.leading, 16.0)
        .padding(.trailing, 31.0)
        .padding(.vertical, 8.0)
        .background(Color(uiColor: .g10))
        .clipShape(RoundedRectangle(cornerRadius: 6.0))
        
    }
}

#Preview {
    DLSearchInput(placeholder: "상품을 검색해주세요.")
        .padding()
}
