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
    
    @State private var alertType: AlertType?
    
    enum AlertType {
        case oneButton
        case twoButton
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    ButtonView()
                        .setStyle(.btnOutlineBgLarge01)
                        .setTitle("1버튼 Alert")
                        .addAction {
                            showAlert(type: .oneButton)
                        }
                    
                    ButtonView()
                        .setStyle(.btnOutlineBgLarge01)
                        .setTitle("2버튼 Alert")
                        .addAction {
                            showAlert(type: .twoButton)
                        }
                    
                    Spacer()
                }
                .padding()
                
                alertView
            }
        }.navigationBarTitle("Alert", displayMode: .inline)
    }
    
    private func showAlert(type: AlertType) {
        alertType = type
    }
    
    @ViewBuilder
    private var alertView: some View {
        if let alertType = alertType {
//            switch alertType {
//            case .oneButton:
//                AlertView()
//                    .addTitle("1버튼 Alert")
//                    .addMessage("1버튼 Alert 테스트")
//                    .addConfirmButton(title: "확인", action: {
//                        print("확인 클릭")
//                        self.alertType = nil
//                    })
//                    .fullSwiftUI()
//                
//            case .twoButton:
//                AlertView()
//                    .addMessage("2버튼 Alert 테스트")
//                    .addConfirmButton(title: "확인", action: {
//                        print("확인 클릭")
//                        self.alertType = nil
//                    })
//                    .addCancelButton(title: "취소", action: {
//                        print("취소 클릭")
//                        self.alertType = nil
//                    })
//                    .fullSwiftUI()
//            }
        }
    }
}

#Preview {
    AlertTestView()
}
