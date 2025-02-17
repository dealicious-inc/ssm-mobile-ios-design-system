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
                Button("1버튼 팝업") {
                    showAlert.toggle()
                }
                .padding()
                .background(.white)
                .foregroundColor(.blue)
                .cornerRadius(10)
                .border(.blue, width: 1)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Alert", displayMode: .inline)
            
            if showAlert {
//                AlertView(isAppeared: $showAlert)
                AlertView()
            }
//            .fullScreenCover(isPresented: $showAlert) {
//                AlertView(isAppeared: $showAlert)
//            }
                
        }
    }
}

#Preview {
    AlertTestView()
}
