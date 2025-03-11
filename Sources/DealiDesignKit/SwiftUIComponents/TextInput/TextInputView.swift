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
        @Published var backgroundColor: Color = Color(ETextInputStatus.normal.backgroundColor)
        
        @Published var inputText: String = ""
        @Published var inputTextColor: Color = Color(ETextInputStatus.normal.textColor)
        
        @Published var placeholder: String = ""
        @Published var titleText: String?
        @Published var helperText: String?
        var normalHelperText: String?
        @Published var helperTextColor: Color = Color(UIColor.g70)
        
        @Published var isRequiredBadgeExposure: Bool = false
        @Published var timerText: String?
        
        @Published var isRightImageExposure: Bool = false
        @Published var borderColor: Color = Color(ETextInputStatus.normal.borderColor)
        
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
    
    private func setTextInputStatus(_ status: ETextInputStatus) {
        viewModel.inputTextColor = Color(status.textColor)
        viewModel.backgroundColor = Color(status.backgroundColor)
        viewModel.borderColor = Color(status.borderColor)
        viewModel.isEnabled = true
        
        switch status {
        case let .error(errorMessage):
            setErrorHelperText(errorMessage: errorMessage)
            viewModel.borderColor = Color(status.borderColor)
            
        case .disabled, .readOnly:
            viewModel.isEnabled = false
            viewModel.borderColor = Color(status.borderColor)
            
        case .focusIn:
            isFocused = true
            viewModel.isClearImageExposure = !viewModel.inputText.isEmpty

        case .focusOut:
            isFocused = false
            viewModel.isClearImageExposure = false
            
        default:
            setNormalHelperText()
        }
    }
    
    private func setErrorHelperText(errorMessage: String?) {
        if let errorMessage = errorMessage {
            viewModel.helperText = errorMessage
            viewModel.helperTextColor = Color(UIColor.error)
        }
        
        viewModel.isRightImageExposure = false
    }
    
    private func setNormalHelperText() {
        if let normalHelperText = viewModel.normalHelperText {
            viewModel.helperText = normalHelperText
            viewModel.helperTextColor = Color(UIColor.g70)
        }
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
                .foregroundStyle(viewModel.inputTextColor)
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
            TimerView
        }
        .padding(EdgeInsets(top: 13, leading: 16, bottom: 13, trailing: 16))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(viewModel.borderColor)
        )
        .background(viewModel.backgroundColor)
        
    }
    
    @ViewBuilder
    private var TextInputView: some View {
        TextField(viewModel.placeholder, text: $viewModel.inputText, onEditingChanged: { isEditing in
            // submit 클릭 등 자연스러운 포커스 변경 시에는 isFocused가 호출되지 않는다고함
            setTextInputStatus(isEditing ? .focusIn : .focusOut)
        })
        .focused($isFocused)
        .foregroundStyle(viewModel.inputTextColor)
        .textFieldStyle(.plain)
        .submitLabel(.done) // 키보드 return 타입
        .keyboardType(.default)
        .disableAutocorrection(true) // 자동수정 비활성화
        .autocapitalization(.none) // 자동 대문자화 비활성화
        .onChange(of: viewModel.inputText) { _ in
            viewModel.isClearImageExposure = !viewModel.inputText.isEmpty
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
        } else {
            ValidImageView
        }
    }
    
    @ViewBuilder
    private var ValidImageView: some View {
        if viewModel.isRightImageExposure {
            Image("ic_check", bundle: .module)
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
    
    @ViewBuilder
    private var TimerView: some View {
        if let timer = viewModel.timerText {
        Text(timer)
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
                    setTextInputStatus(.focusOut)
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
        viewModel.normalHelperText = text
        setNormalHelperText()
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
    func setMandatory() -> Self {
        viewModel.isRequiredBadgeExposure = true
        return self
    }
    
    @discardableResult
    func setInputStatus(_ status: ETextInputStatus) -> Self {
        setTextInputStatus(status)
        return self
    }
    
    @discardableResult
    func setTimer(_ seconds: Int) -> Self {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        viewModel.timerText = formattedTime
        
        return self
    }
    
    @discardableResult
    func setConfirmed(_ isConfirmed: Bool) -> Self {
        setTextInputStatus(.normal)
        viewModel.isRightImageExposure = isConfirmed
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
        setTextInputStatus(isEnabled ? .normal : .disabled)
        return self
    }
}
