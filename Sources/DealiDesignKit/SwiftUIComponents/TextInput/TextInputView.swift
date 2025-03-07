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
        @Published var inputText: String = ""
        @Published var placeholder: String = ""
        @Published var titleText: String?
        @Published var helperText: String?
        @Published var helperTextColor: Color = Color(UIColor.g70)
        
        @Published var isRequiredBadgeExposure: Bool = false
        @Published var isTimerExposure: Bool = false
        
        @Published var isValidImageExposure: Bool = false
        @Published var isValid: Bool = false
        @Published var borderColor: Color = Color(UIColor.g20)
        
        @Published var isClearImageExposure: Bool = false
        
        @Published var buttonTitle: String?
        @Published var isButtonExposure: Bool = false
        var buttonAction: () -> Void = {}
        
        @Published var isEnabled: Bool = true
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            TitleTextView
            
            HStack(spacing: 8) {
                TextInputContainerView
                ButtonContainerView
            }
            
            HelperTextView
        }
    }
    
    public init() { }
    
    #warning("상태에 따른 디자인 변경 필요")
    private func setTextInputStatus(_ enabled: Bool) {
        // enabled, disabled
        
        // focused
        
        // normal
        
        // error
    }
    
    private func setValidation(isValid: Bool) {
        viewModel.isValid = isValid
        viewModel.isValidImageExposure = isValid
        
        let errorColor = Color(UIColor.error)
        viewModel.borderColor = isValid ? Color(UIColor.g20) : errorColor
        viewModel.helperTextColor = isValid ? Color(UIColor.g70) : errorColor
    }
}

#Preview {
    TextInputView()
}

// MARK: - ViewBuilder
public extension TextInputView {
    @ViewBuilder
    private var TitleTextView: some View {
        if let title = viewModel.titleText, !title.isEmpty {
            Text(title)
                .font(Font(UIFont.b2r14))
                .foregroundStyle(Color(UIColor.g100))
                .overlay(
                    Group {
                        if viewModel.isRequiredBadgeExposure {
                            Color(UIColor.primary01)
                                .frame(width: 5, height: 5)
                                .clipShape(Circle())
                                .padding(.top, 4)
                                .offset(x: 9)
                        }
                    },
                    alignment: .topTrailing
                )
        }
    }
    
    @ViewBuilder
    private var HelperTextView: some View {
        if let helper = viewModel.helperText, !helper.isEmpty {
            Text(helper)
                .font(Font(UIFont.b4r12))
                .foregroundStyle(viewModel.helperTextColor)
                .padding(.horizontal, 4)
        }
    }
    
    @ViewBuilder
    private var TextInputContainerView: some View {
        HStack(spacing: 16) {
            TextInputView
            ClearImageView
            ValidImageView
            TimerView
        }
        .padding(EdgeInsets(top: 13, leading: 16, bottom: 13, trailing: 16))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(viewModel.borderColor)
        )
    }
    
    @ViewBuilder
    private var TextInputView: some View {
        TextField(viewModel.placeholder, text: $viewModel.inputText)
            .textFieldStyle(.plain)
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
    }
    
    @ViewBuilder
    private var ClearImageView: some View {
        if viewModel.isClearImageExposure {
            Image("ic_x_circle_filled", bundle: .module)
                .resizable() // 리사이즈 가능하게 함
                .renderingMode(.template) // 템플릿 모드 설정으로 색상 변경 가능하게 함
                .foregroundColor(Color(UIColor.g50)) // resizable 보다 나중에 호출 필요 (반환타입이 some View)
                .aspectRatio(contentMode: .fit) // 원본 비율 유지하면서 맞춤
                .frame(width: 16, height: 16)
        }
    }
    
    @ViewBuilder
    private var ValidImageView: some View {
        if viewModel.isValidImageExposure && viewModel.isValid {
            Image("ic_check", bundle: .module)
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
    
    @ViewBuilder
    private var TimerView: some View {
        if viewModel.isTimerExposure {
            Text("05:00")
                .font(Font(UIFont.b2r14))
                .foregroundStyle(Color(UIColor.error))
        }
    }
    
    @ViewBuilder
    private var ButtonContainerView: some View {
        if viewModel.isButtonExposure {
            ButtonView()
                .setStyle(.btnFilledTonalMedium03)
                .setTitle(viewModel.buttonTitle ?? "")
                .setEnabled(viewModel.isEnabled)
                .addAction {
                    isFocused = false
                    viewModel.buttonAction()
                }
                .frame(width: 84)
        }
    }
}

// MARK: - Set ViewModel
public extension TextInputView {
    @discardableResult
    func setTitleText(_ text: String) -> Self {
        viewModel.titleText = text
        return self
    }
    
    @discardableResult
    func setHelperText(_ text: String) -> Self {
        viewModel.helperText = text
        return self
    }
    
    @discardableResult
    func setInputText(_ text: String) -> Self {
        viewModel.inputText = text
        return self
    }
    
    @discardableResult
    func setPlaceholder(_ text: String) -> Self {
        viewModel.placeholder = text
        return self
    }
    
    @discardableResult
    func setRequiredBadge() -> Self {
        viewModel.isRequiredBadgeExposure = true
        return self
    }
    
    // 시간 text 지정 필요.. 혹은 내부에서 timer 돌리는 방식이라던가,, 그럼 invalidate도 유의하고 잔여시간도 외부에서 get 할 수 있어야함
    @discardableResult
    func setTimer() -> Self {
        viewModel.isTimerExposure = true
        return self
    }
    
    @discardableResult
    func setConfirmButton(title: String, action: @escaping () -> Void) -> Self {
        viewModel.isButtonExposure = true
        viewModel.buttonTitle = title
        viewModel.buttonAction = action
        return self
    }
    
    @discardableResult
    func setEnabled(_ isEnabled: Bool) -> Self {
        viewModel.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func setValid(isValid: Bool) -> Self {
        setValidation(isValid: isValid)
        return self
    }
}
