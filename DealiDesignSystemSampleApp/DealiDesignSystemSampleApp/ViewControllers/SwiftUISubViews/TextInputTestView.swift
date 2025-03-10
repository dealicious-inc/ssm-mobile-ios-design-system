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
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    TextInputView()
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                        .setMandatory()
                        .setConfirmButton(title: "확인", action: {
                            print("확인")
                        })
                    
                    TextInputView()
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                        .setMandatory()
                        .setTimer(250)
                    
                    TextInputView()
                        .setInputText("Text InputText InputText InputText InputText InputText InputText InputText InputText InputText Input")
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                    
                    TextInputView()
                        .setInputText("Error Input")
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                        .setInputStatus(.error("errorMessage show"))
                    
                    TextInputView()
                        .setInputText("ReadOnly Input")
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                        .setInputStatus(.readOnly)
                    
                    TextInputView()
                        .setInputText("Disabled Input")
                        .setTitleText("타이틀 텍스트")
                        .setHelperText("헬퍼 텍스트")
                        .setPlaceholder("Placeholder Text")
                        .setInputStatus(.disabled)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(10)
            }
            .frame(maxWidth: .infinity)
        }.navigationBarTitle("TextInput", displayMode: .inline)
    }
}

#Preview {
    TextInputTestView()
}
