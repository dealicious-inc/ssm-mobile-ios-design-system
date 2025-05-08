//
//  DLSearchInput.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/31/25.
//

import SwiftUI

public struct DLSearchInput: View {
    @Binding private var text: String
    @Binding var isFocused: Bool
    @FocusState private var internalFocus: Bool
    
    public var placeholder: String = "상품을 검색해주세요."
    public var onSearch: (() -> Void) = { }
    
    public init(text: Binding<String>, isFocused: Binding<Bool>, placeholder: String, onSearch: (() -> Void)? = nil) {
        self._text = text
        self._isFocused = isFocused
        self.placeholder = placeholder
        self.onSearch = onSearch ?? { }
    }
    
    private var isClearButtonVisible: Bool {
        !text.isEmpty
    }
    
    public var body: some View {
        ZStack {
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
                .focused($internalFocus)
                .onChange(of: isFocused) { internalFocus = $0 }
                .onChange(of: internalFocus) { isFocused = $0 }
                .onSubmit {
                    self.isFocused = false
                    self.onSearch()
                }
                .disableAutocorrection(true)
                
                buttonContainerView
            }
            .frame(height: 24.0)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            .background(Color(uiColor: .g10))
            .clipShape(RoundedRectangle(cornerRadius: 6.0))
        }
        .padding(.vertical, 4.0)
        .padding(.horizontal, 16.0)
    }
    
    private var buttonContainerView: some View {
        HStack(spacing: 12.0) {
            if isClearButtonVisible {
                clearButton
            }
            
            if isFocused {
                searchButton
            }
        }
    }
    
    private var clearButton: some View {
        Button {
            self.text = ""
        } label: {
            Image.dealiIcon(named: "ic_x_circle_filled")
                .resizable()
                .renderingMode(.template)
                .frame(width: 16.0, height: 16.0)
                .foregroundStyle(Color(.g50))
            
        }
    }
    
    private var searchButton: some View {
        Button(action: {
            self.isFocused = false
            self.onSearch()
        }, label: {
            Image.dealiIcon(named: "ic_search")
        })
    }
}


struct DLSearchInput_Previews: PreviewProvider {
 
    static var previews: some View {
        Group {
            DLSearchInput(text: .constant(""), isFocused: .constant(false), placeholder: "상품을 검색해주세요")
                .previewDisplayName("기본")
            
            DLSearchInput(text: .constant("텍스트 입력 중"), isFocused: .constant(true), placeholder: "상품을 검색해주세요")
                .previewDisplayName("입력 중")
            
            DLSearchInput(text: .constant("텍스트 입력 완료"), isFocused: .constant(false), placeholder: "상품을 검색해주세요")
                .previewDisplayName("입력 후")
        }
        .previewLayout(.sizeThatFits)
    }
}
