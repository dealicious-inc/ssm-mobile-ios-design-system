//
//  File.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 5/13/25.
//

import SwiftUI

struct DLToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    DLToastView(message: message)
                        .transition(
                            .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top))
                        )
                }
                .padding(.bottom, 40)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        isPresented = false
                        
                    }
                }
            }
        }
        .animation(.easeIn(duration: 0.2), value: isPresented)
        
    }
}

public extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: TimeInterval = 3.0) -> some View {
        return self.modifier(DLToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}

struct DLToastPreviewWrapper: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Button {
                isPresented = true
            } label: {
                Text("토스트 노출")
            }
        }
        .toast(isPresented: $isPresented, message: "사업자 인증을 진행해주세요.")
    }
}

struct DLToastModifier_Previews: PreviewProvider {
    static var previews: some View {
        DLToastPreviewWrapper()
    }
}
