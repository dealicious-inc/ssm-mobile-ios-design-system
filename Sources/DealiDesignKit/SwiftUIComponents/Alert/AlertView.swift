//
//  AlertView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/14/25.
//

import SwiftUI

public struct AlertView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject
    private var viewModel: ViewModel = ViewModel()
    
    @State private var backgroundOpacity = 0.0
    @State private var opacity = 0.0
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    final class ViewModel: ObservableObject {
        @Published var title: String?
        @Published var message: String?
    }
    
    public var body: some View {
        ZStack{
            Color(.b40).opacity(opacity).ignoresSafeArea()
            
            VStack {
                Text(viewModel.title ?? "")
                    .font(Font(UIFont.sh2sb18))
                    .foregroundStyle(Color(UIColor.g100))
//                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10)
                
                Text(viewModel.message ?? "")
                    .font(Font(UIFont.sh3r16))
                    .foregroundStyle(Color(UIColor.g80))
//                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer().frame(height: 24)
                
                HStack(spacing: 10) {
                    Button("확인") {
                        withAnimation(dismissAnimation) {
                            opacity = 0.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .font(Font(UIFont.b2sb14))
                    .frame(maxWidth: .infinity, maxHeight: 46.0)
                    .background(Color(UIColor.primary01))
                    .foregroundColor(.white)
                    .cornerRadius(6.0)
                }
                
            }
            .padding(.top, 24.0)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: 280.0)
            .background(Color.white).opacity(opacity)
            .cornerRadius(10.0)
        }
        .onAppear {
            withAnimation(presentAnimation) {
                opacity = 1.0
            }
        }
        .onTapGesture {
            withAnimation(dismissAnimation) {
                opacity = 0.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    public init() {}
    
}

public extension AlertView {
    
    @discardableResult
    mutating func addTitle(_ title: String) -> AlertView {
        viewModel.title = title
        return self
    }
    
    @discardableResult
    mutating func addMessage(_ message: String) -> AlertView {
        viewModel.message = message
        return self
    }
}

#Preview {
    AlertView()
}

