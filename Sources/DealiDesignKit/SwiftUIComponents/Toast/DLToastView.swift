//
//  DLToastView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/13/25.
//

import SwiftUI

public struct DLToastView: View {
    let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        Text(message)
            .font(Font(UIFont.b2sb14))
            .foregroundColor(.white)
            .padding(16)
            .background(Color(.g100))
            .clipShape(RoundedRectangle(cornerRadius: 6.0))
            .shadow(color: .black.opacity(0.22), radius: 3.5, x: 0, y: 2)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.easeInOut(duration: 0.3), value: message)
    }
}

struct DLToastView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DLToastView(message: "사업자 인증을 진행해주세요. ")
            DLToastView(message: "정상적으로 인증 되었습니다. 정보 확인 후 영문 상호명을 반드시 입력해주세요.")

        }
    }
}

