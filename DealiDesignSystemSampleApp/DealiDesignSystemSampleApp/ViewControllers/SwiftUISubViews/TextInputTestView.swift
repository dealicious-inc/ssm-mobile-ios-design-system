//
//  TextInputTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 3/7/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct TextInputTestView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextInputView()
                    .setTitleText("타이틀 텍스트")
                    .setHelperText("헬퍼 텍스트")
                    .setPlaceholder("Placeholder Text")
                    .setRequiredBadge()
                    .setConfirmButton(title: "확인", action: {
                        print("확인")
                    })
                
                TextInputView()
                    .setTitleText("타이틀 텍스트")
                    .setHelperText("헬퍼 텍스트")
                    .setPlaceholder("Placeholder Text")
                    .setRequiredBadge()
                    .setTimer()
                
                TextInputView()
                    .setInputText("Text Input")
                    .setTitleText("타이틀 텍스트")
                    .setHelperText("헬퍼 텍스트")
                    .setPlaceholder("Placeholder Text")
                    .setValid(isValid: false)
                
                TextInputView()
                    .setInputText("Text InputText InputText InputText InputText InputText InputText InputText InputText InputText Input")
                    .setInputText("Text Input")
                    .setTitleText("타이틀 텍스트")
                    .setHelperText("헬퍼 텍스트")
                    .setPlaceholder("Placeholder Text")
                
                Spacer()
            }
            .padding(20)
        }.navigationBarTitle("TextInput", displayMode: .inline)
    }
}

#Preview {
    TextInputTestView()
}
