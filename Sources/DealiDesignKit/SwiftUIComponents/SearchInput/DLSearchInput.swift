//
//  DLSearchInput.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 3/31/25.
//

import SwiftUI
import Combine

public final class DLSearchInputViewModel: ObservableObject {
    @Published public var text: String = ""
    @Published public var isFocused: Bool = false

    public init(text: String = "", isFocused: Bool = false) {
        self.text = text
        self.isFocused = isFocused
    }
}

public struct DLSearchInput: View {
    @ObservedObject public var viewModel: DLSearchInputViewModel
    @FocusState private var internalFocus: Bool

    public var placeholder: String = "상품을 검색해주세요."
    public var onSearch: () -> Void = { }

    public init(
        viewModel: DLSearchInputViewModel,
        placeholder: String = "상품을 검색해주세요.",
        onSearch: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.placeholder = placeholder
        self.onSearch = onSearch ?? { }
    }

    public var body: some View {
        ZStack {
            HStack(spacing: 16.0) {
                TextField(
                    "",
                    text: $viewModel.text,
                    prompt: Text(placeholder)
                        .foregroundColor(Color(uiColor: .g60))
                        .font((Font(UIFont.b2r14)))
                )
                .font(Font(UIFont.b2r14))
                .foregroundStyle(Color(uiColor: .g100))
                .disableAutocorrection(true)

                buttonContainerView
            }
            .frame(height: 24.0)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            .background(Color(uiColor: .g10))
            .clipShape(RoundedRectangle(cornerRadius: 6.0))
        }
        .padding(.vertical, 4.0)
        .padding(.horizontal, 16.0)
        .focused($internalFocus)
        .onSubmit {
            viewModel.isFocused = false
            onSearch()
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

    private var buttonContainerView: some View {
        HStack(spacing: 12.0) {
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
            withAnimation(.easeInOut(duration: 0.1)) {
                viewModel.text = ""
            }
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
            viewModel.isFocused = false
            onSearch()
        }, label: {
            Image.dealiIcon(named: "ic_search")
        })
    }
}


struct DLSearchInput_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            DLSearchInput(
                viewModel: .init(),
                placeholder: "상품을 검색해주세요"
            )
            .previewDisplayName("기본")

            DLSearchInput(
                viewModel: .init(text: "텍스트 입력", isFocused: true),
                placeholder: "상품을 검색해주세요"
            )
            .previewDisplayName("입력 중")

            DLSearchInput(
                viewModel: .init(text: "텍스트 입력"),
                placeholder: "상품을 검색해주세요"
            )
            .previewDisplayName("입력 후")
        }
        .previewLayout(.sizeThatFits)
    }
}
