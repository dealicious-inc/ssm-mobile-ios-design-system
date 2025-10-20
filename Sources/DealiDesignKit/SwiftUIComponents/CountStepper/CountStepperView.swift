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
    @Published public var isMinusButtonEnabled: Bool = true
    @Published public var isPlusButtonEnabled: Bool = true
    @Published public var minValue: Int = 0
    @Published public var maxValue: Int = 999
    
    public init(
        value: Int = 0,
        isEnabled: Bool = true,
        isMinusButtonEnabled: Bool = true,
        isPlusButtonEnabled: Bool = true,
        minValue: Int = 0,
        maxValue: Int = 999
    )
    {
        self.value = value
        self.isEnabled = isEnabled
        self.isMinusButtonEnabled = isMinusButtonEnabled
        self.isPlusButtonEnabled = isPlusButtonEnabled
        self.minValue = minValue
        self.maxValue = maxValue
    }
}

public struct CountStepperView: View {
    
    public var valueChanged: ((Int) -> Void)?
    @ObservedObject public var viewModel: CountStepperViewModel
    
    private var canDecrement: Bool {
        self.viewModel.value > self.viewModel.minValue
    }
    private var canIncrement: Bool {
        self.viewModel.value < self.viewModel.maxValue
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Button(action: self.decrement) {
                Image.dealiIcon(named: "ic_minus")
                    .renderingMode(.template)
                    .foregroundStyle(self.viewModel.isMinusButtonEnabled ? Color(uiColor: .primary05) : Color(uiColor: .g40))
            }
            .frame(width: 32.0, height: 32.0)
            .disabled(!self.viewModel.isEnabled || !self.viewModel.isMinusButtonEnabled)
        }
    }
    
    public init(viewModel: CountStepperViewModel = CountStepperViewModel(), valueChanged: ((Int) -> Void)? = nil) {
        self.viewModel = viewModel
        self.valueChanged = valueChanged
    }
    
    private func increment() {
        guard self.canIncrement else { return }
    }
    
    private func decrement() {
        guard self.canDecrement else { return }
    }
}

#Preview {
    CountStepperView()
}
