//
//  CountStepperView.swift
//  DealiDesignKit
//
//  Created by 이남준 on 10/20/25.
//

import SwiftUI

public final class CountStepperViewModel: ObservableObject {
    @Published public var value: Int = 0
    @Published public var isEnabled: Bool = true
    @Published public var minValue: Int = 0
    @Published public var maxValue: Int = 999
    @Published public var acceptCountWhenEditingDidEnd: Bool = false
    
    public var isMinusButtonEnabled: Bool {
        return self.value > self.minValue
    }
    
    public var isPlusButtonEnabled: Bool {
        return self.value < self.maxValue
    }
    
    public init(
        value: Int = 0,
        isEnabled: Bool = true,
        minValue: Int = 0,
        maxValue: Int = 999,
        acceptCountWhenEditingDidEnd: Bool = false
    ) {
        self.value = value
        self.isEnabled = isEnabled
        self.minValue = minValue
        self.maxValue = maxValue
        self.acceptCountWhenEditingDidEnd = acceptCountWhenEditingDidEnd
    }
}

public struct CountStepperView: View {
    
    public var valueChanged: ((Int) -> Void)?
    @ObservedObject public var viewModel: CountStepperViewModel
    
    private var canDecrement: Bool {
        self.viewModel.isEnabled && self.viewModel.isMinusButtonEnabled
    }
    
    private var canIncrement: Bool {
        self.viewModel.isEnabled && self.viewModel.isPlusButtonEnabled
    }
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var tempText: String = ""
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    public var body: some View {
        HStack(spacing: 0) {
            Button(action: self.decrement) {
                Image.dealiIcon(named: "ic_minus")
                    .renderingMode(.template)
                    .foregroundStyle(self.canDecrement ? Color(uiColor: .g100) : Color(uiColor: .g40))
            }
            .frame(width: 30.0, height: 30.0)
            .disabled(!self.canDecrement)
            
            TextField(
                "",
                text: self.bindingText
            )
            .foregroundStyle(self.viewModel.isEnabled ? Color(UIColor.g100) : Color(UIColor.g50))
            .focused(self.$isTextFieldFocused)
            .frame(width: 40.0, height: 30.0)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onChange(of: self.isTextFieldFocused) { focused in
                if !focused {
                    self.commitEditing()
                }
            }
            .overlay(
                Rectangle()
                    .stroke(self.isTextFieldFocused ? Color(uiColor: .g100) : Color(uiColor: .g30))
                    .frame(height: 30.0)
            )
            
            Button(action: self.increment) {
                Image.dealiIcon(named: "ic_plus")
                    .renderingMode(.template)
                    .foregroundStyle(self.canIncrement ? Color(uiColor: .g100) : Color(uiColor: .g40))
            }
            .frame(width: 30.0, height: 30.0)
            .disabled(!self.canIncrement)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 6.0)
                .stroke(self.borderColor)
                .frame(height: 30.0)
        )
        .disabled(!self.viewModel.isEnabled)
        .onAppear {
            self.tempText = String(self.viewModel.value)
        }
        .background(Color(UIColor.primary04))
    }
    
    public init(viewModel: CountStepperViewModel = CountStepperViewModel(), valueChanged: ((Int) -> Void)? = nil) {
        self.viewModel = viewModel
        self.valueChanged = valueChanged
    }
    
    // MARK: - Binding
    private var bindingText: Binding<String> {
        Binding<String>(
            get: { self.isTextFieldFocused ? self.tempText : String(self.viewModel.value) },
            set: { newValue in
                let filtered = newValue.filter { $0.isNumber }
            
                if let intValue = Int(filtered) {
                    let clamped = min(max(intValue, self.viewModel.minValue), self.viewModel.maxValue)
                    self.tempText = String(clamped)
                    
                    if !self.viewModel.acceptCountWhenEditingDidEnd {
                        if self.viewModel.value != clamped {
                            self.viewModel.value = clamped
                            self.valueChanged?(clamped)
                        }
                    }
                } else {
                    self.tempText = String(self.viewModel.minValue)
                    if !self.viewModel.acceptCountWhenEditingDidEnd {
                        self.viewModel.value = self.viewModel.minValue
                        self.valueChanged?(self.viewModel.value)
                    }
                }
            }
        )
    }
    
    // MARK: - Actions
    private func commitEditing() {
        guard self.viewModel.acceptCountWhenEditingDidEnd else { return }
        
        if let intValue = Int(self.tempText) {
            let clamped = min(max(intValue, self.viewModel.minValue), self.viewModel.maxValue)
            if self.viewModel.value != clamped {
                self.viewModel.value = clamped
                self.valueChanged?(clamped)
            }
        } else {
            self.viewModel.value = self.viewModel.minValue
            self.valueChanged?(self.viewModel.value)
        }
    }
    
    private func increment() {
        self.isTextFieldFocused = false
        guard canIncrement else { return }
        self.viewModel.value += 1
        self.tempText = String(self.viewModel.value)
        self.valueChanged?(self.viewModel.value)
    }
    
    private func decrement() {
        self.isTextFieldFocused = false
        guard canDecrement else { return }
        self.viewModel.value -= 1
        self.tempText = String(self.viewModel.value)
        self.valueChanged?(self.viewModel.value)
    }
    
    private var borderColor: Color {
        if !self.viewModel.isEnabled {
            return Color(uiColor: .g20)
        }
        return self.isTextFieldFocused ? Color(uiColor: .g100) : Color(uiColor: .g30)
    }
}

#Preview {
    HStack {
        CountStepperPreview()
    }
        
    
}

struct CountStepperPreview: View {
    @StateObject var vm = CountStepperViewModel(
        value: 100, isEnabled: true, minValue: 99, maxValue: 101
    )

    var body: some View {
        VStack {
            CountStepperView(viewModel: vm)
            Text("\(vm.value)")
        }
        .background(Color.red)
    }
}
