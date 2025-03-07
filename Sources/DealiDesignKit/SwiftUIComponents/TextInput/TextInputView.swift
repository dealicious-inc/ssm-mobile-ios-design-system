//
//  TextInputView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 3/7/25.
//

import SwiftUI

public struct TextInputView: View {
    
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    @FocusState private var isFocused: Bool // 키보드 포커스 바인딩
    
    final private class ViewModel: ObservableObject {
        @Published var text: String = ""
        @Published var isTimerExposure: Bool = false
        @Published var isValidImageExposure: Bool = false
        @Published var isClearImageExposure: Bool = false
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            TitleTextView
            HStack(spacing: 8) {
                TextInputContainerView
                
                ButtonView()
                .setStyle(.btnFilledTonalMedium03)
                .setTitle("Button")
                .addAction {
                    isFocused = false
                }
                .frame(width: 84)
            }
            HelperTextView
        }
        .padding() // border 확인 목적
    }
    
    public init() { }
    
    @ViewBuilder
    private var TitleTextView: some View {
        Text("Label")
            .font(Font(UIFont.b2r14))
            .foregroundStyle(Color(UIColor.g100))
            .background(Color.yellow)
    }
    
    @ViewBuilder
    private var HelperTextView: some View {
        Text("Helper Text")
            .font(Font(UIFont.b4r12))
            .foregroundStyle(Color(UIColor.g70))
            .background(Color.mint)
            .padding(.horizontal, 4)
    }
    
    @ViewBuilder
    private var TextInputContainerView: some View {
        HStack(spacing: 16) {
            TextField("Text Input", text: $viewModel.text)
                .textFieldStyle(.plain)
                .background(Color.green)
            
                .submitLabel(.done) // 키보드 return 타입
                .keyboardType(.default)
                .disableAutocorrection(true) // 자동수정 비활성화
            
                .focused($isFocused)
                .onChange(of: isFocused) { focused in
                    viewModel.isClearImageExposure = focused
                }
                .onSubmit {
                    isFocused = false
                }
            
            if viewModel.isClearImageExposure {
                Image("ic_x_circle_filled", bundle: .module)
                    .resizable() // 리사이즈 가능하게 함
                    .renderingMode(.template) // 템플릿 모드 설정으로 색상 변경 가능하게 함
                    .foregroundColor(Color(UIColor.g50)) // resizable 보다 나중에 호출 필요 (반환타입이 some View)
                    .aspectRatio(contentMode: .fit) // 원본 비율 유지하면서 맞춤
                    .frame(width: 16, height: 16)
            }
            
            if viewModel.isValidImageExposure {
                Image("ic_check", bundle: .module)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            
            if viewModel.isTimerExposure {
                Text("05:00")
                    .font(Font(UIFont.b2r14))
                    .foregroundStyle(Color(UIColor.error))
                    .background(Color.yellow)
            }
        }
        .padding(EdgeInsets(top: 13, leading: 16, bottom: 13, trailing: 16))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(Color(UIColor.g20))
        )
    }
}

#Preview {
    TextInputView()
}
