//
//  AlertTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/17/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct AlertTestView: View {
    
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                ButtonView().btnFilledLarge01()
                    .addTitle("1버튼 Alert")
                    .addAction {
                        showAlert.toggle()
                    }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Alert", displayMode: .inline)
            
            if showAlert {
                AlertView()
                    .addTitle("1버튼 Alert")
                    .addMessage("SwiftUI 테스트")
            }
        }
    }
}

#Preview {
    AlertTestView()
}
