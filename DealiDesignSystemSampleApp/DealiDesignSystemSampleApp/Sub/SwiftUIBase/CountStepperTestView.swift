//
//  CountStepperTestView.swift
//  DealiDesignKit
//
//  Created by 이남준 on 10/22/25.
//

import SwiftUI
import DealiDesignKit

struct CountStepperTestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            CountStepperView()
            CountStepperView(
                viewModel: CountStepperViewModel(
                    value: 0,
                    isEnabled: true,
                    minValue: 0,
                    maxValue: 2,
                    acceptCountWhenEditingDidEnd: true
                )
            )
            CountStepperView(
                viewModel: CountStepperViewModel(
                    value: 1,
                    isEnabled: false,
                    minValue: 0,
                    maxValue: 5
                )
            )
        }
    }
}

#Preview {
    CountStepperTestView()
}

//struct CheckboxTestView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20.0) {
//            CheckboxView()
//            CheckboxView(label: "기본 상태")
//            CheckboxView(label: "선택 상태", viewModel: .init(isSelected: true))
//            CheckboxView(label: "비활성화 비선택 상태", viewModel: .init(isEnabled: false))
//            CheckboxView(label: "비활성화 선택 상태", viewModel: .init(isSelected: true, isEnabled: false))
//        }
//    }
//}
//
//#Preview {
//    CheckboxTestView()
//}

