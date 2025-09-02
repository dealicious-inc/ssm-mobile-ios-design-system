//
//  CheckboxTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 3/6/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct CheckboxTestView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            CheckboxView()
            CheckboxView(label: "기본 상태")
            CheckboxView(label: "선택 상태", viewModel: .init(isSelected: true))
            CheckboxView(label: "비활성화 비선택 상태", viewModel: .init(isEnabled: false))
            CheckboxView(label: "비활성화 선택 상태", viewModel: .init(isSelected: true, isEnabled: false))
        }
    }
}

#Preview {
    CheckboxTestView()
}
