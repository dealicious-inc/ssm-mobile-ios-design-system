//
//  ToastTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 5/13/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI

struct ToastTestView: View {
    
    @State private var isPresented = false
    @State private var isPresented2 = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    isPresented = true
                } label: {
                    Text("인증 성공 토스트")
                }
                
                Button {
                    isPresented2 = true
                } label: {
                    Text("사업자 인증 요구 토스트")
                }
            }
        }
        .toast(isPresented: $isPresented, message: "정상적으로 인증 되었습니다. 정보 확인 후 영문 상호명을 반드시 입력해주세요.")
        .toast(isPresented: $isPresented2, message: "사업자 인증을 진행해주세요.")
    }
}

#Preview {
    ToastTestView()
}
