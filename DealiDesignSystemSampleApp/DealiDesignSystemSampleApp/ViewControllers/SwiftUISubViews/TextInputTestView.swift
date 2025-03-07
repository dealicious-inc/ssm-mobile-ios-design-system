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
                    Spacer()
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }.navigationBarTitle("TextInput", displayMode: .inline)
    }
}

#Preview {
    TextInputTestView()
}
