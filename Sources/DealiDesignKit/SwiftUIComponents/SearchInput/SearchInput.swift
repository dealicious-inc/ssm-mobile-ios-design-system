//
//  SearchInput.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/31/25.
//

import SwiftUI
import Combine

@MainActor
public final class SearchInputViewModel: ObservableObject {
    @Published public var placeholder: String
    @Published public var text: String = ""
    @Published public var isFocused: Bool = false
    @Published public var keyword: String?
    @Published public var resetTextWhenClearTapped: Bool = true
    
    public init(placeholder: String = "상품을 검색해주세요.",
                text: String = "", isFocused: Bool = false,
                keyword: String? = nil,
                resetTextWhenClearTapped: Bool = true) {
        self.placeholder = placeholder
        self.text = text
        self.isFocused = isFocused
        self.keyword = keyword
        self.resetTextWhenClearTapped = resetTextWhenClearTapped
    }
}

public struct SearchInput: View {
    @ObservedObject public var viewModel: SearchInputViewModel
    @FocusState private var internalFocus: Bool
    
    public var onClear: () -> Void
    public var onSearch: (String) -> Void
        
    public init(
        viewModel: SearchInputViewModel,
        onClear: @escaping (() -> Void) = { },
        onSearch: @escaping ((String) -> Void) = { _ in },
    ) {
        self.viewModel = viewModel
        self.onClear = onClear
        self.onSearch = onSearch
    }
    
    enum Constants {
        static let maxKeywordWidth: CGFloat = 92.0
        
        static let height: CGFloat = 24.0
        static let leadingPadding: CGFloat = 16.0
        static let trailingPadding: CGFloat = 12.0

        static let verticalPadding: CGFloat = 8.0
        static let cornerRadius: CGFloat = 6.0
    }

    public var body: some View {
        ZStack {
            HStack(spacing: 8.0) {
                if let keyword = viewModel.keyword {
                    TagView(text: keyword, type: .tagOutlineLarge04)
                        .frame(maxWidth: Constants.maxKeywordWidth, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false)
                }
                
                textField
                buttonContainerView
            }
            .frame(height: Constants.height)
            .padding(.vertical, Constants.verticalPadding)
            .padding(.trailing, Constants.trailingPadding)
            .padding(.leading, viewModel.keyword == nil ? Constants.leadingPadding : 8.0)
            .background(Color(uiColor: .g10))
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        }
        .focused($internalFocus)
        .onSubmit {
            viewModel.isFocused = false
            onSearch(viewModel.text)
        }
        .onChange(of: internalFocus) { newValue in
            if viewModel.isFocused != internalFocus {
                viewModel.isFocused = internalFocus
            }
        }
        .onChange(of: viewModel.isFocused) { newValue in
            if internalFocus != viewModel.isFocused {
                internalFocus = viewModel.isFocused
            }
        }
    }
    
    private var textField: some View {
        TextField(
            "",
            text: $viewModel.text,
            prompt: Text(viewModel.placeholder)
                .foregroundColor(Color(uiColor: .g60))
                .font((Font(UIFont.b2r14)))
        )
        .submitLabel(.search)
        .textInputAutocapitalization(.never)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(Font(UIFont.b2r14))
        .foregroundStyle(Color(uiColor: .g100))
        .disableAutocorrection(true)
    }

    private var buttonContainerView: some View {
        HStack(spacing: 8.0) {
            if !viewModel.text.isEmpty {
                clearButton
            }

            if viewModel.isFocused || viewModel.text.isEmpty {
                searchButton
            }
        }
    }

    private var clearButton: some View {
        Button {
            if viewModel.resetTextWhenClearTapped {
                withAnimation(.easeInOut(duration: 0.1)) {
                    viewModel.text = ""
                }
            }
            onClear()
        } label: {
            Image.dealiIcon(named: "ic_x_circle_filled")
                .resizable()
                .renderingMode(.template)
                .frame(width: 16.0, height: 16.0)
                .foregroundStyle(Color(.g50))
                .padding(4.0)
        }
    }

    private var searchButton: some View {
        Button(action: {
            viewModel.isFocused = false
            onSearch(viewModel.text)
        }, label: {
            Image.dealiIcon(named: "ic_search")
        })
    }
}


struct SearchInput_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SearchInput(
                    viewModel: .init()
                )
                
                SearchInput(
                    viewModel: .init(text: "텍스트 입력 중", isFocused: true)
                )
                
                SearchInput(
                    viewModel: .init(text: "텍스트 입력 완료")
                )
                
                SearchInput(
                    viewModel: .init(text: "키워드 있을 때", keyword: "아우터")
                )
                
                SearchInput(
                    viewModel: .init(text: "키워드 길 때", keyword: "ChangeKeyword")
                )
            }
            .padding()
            .previewDisplayName("기본")
        }
        .previewLayout(.sizeThatFits)
    }
}
