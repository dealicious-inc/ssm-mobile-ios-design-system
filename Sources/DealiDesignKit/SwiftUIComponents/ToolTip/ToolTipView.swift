//
//  ToolTipView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 3/27/25.
//

import SwiftUI

public struct ToolTipView: View {
    /// For UIKit Base
    @Environment(\.dismiss) private var dismiss
    /// For Full SwiftUI Base
    @Binding var isPresented: Bool
    
    @State private var opacity = 0.0
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    public var body: some View {
        ZStack {
            Color(.clear).opacity(opacity)
            
            Text("Top Right")
                .font(Font(UIFont.b3sb13))
                .foregroundColor(.white)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 6.0)
                        .fill(Color(UIColor.secondary01))
                )
                .overlay(
                    tailImage
                        .scaleEffect(x: 1, y: -1)
                        .offset(x: -21, y: -6),
                    alignment: .topTrailing
                    
                )
        }
        .onAppear { viewAppear() }
        .onTapGesture { viewDismiss() }
    }
    
    public init(isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
    
    @ViewBuilder
    private var tailImage: some View {
        Image("img_tailanchor", bundle: .module)
            .resizable()
            .frame(width: 12, height: 6)
    }
    
    private func viewAppear() {
        withAnimation(presentAnimation) {
            opacity = 1.0
        }
    }
    
    private func viewDismiss() {
        withAnimation(dismissAnimation) {
            opacity = 0.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration) {
//            if viewModel.isFullSwiftUI {
//                // NavigationLink를 사용하지 않은 SwiftUI View에서 Alert노출 시, 하단 View가 함께 dismiss되어서 isPresented를 사용.
//                isPresented = false
//            } else {
                // UIKit에서는 하위 뷰 dismiss 처리
                dismiss()
//            }
        }
    }
    
    public func show(_ sourceViewController: UIViewController) {
        let hostingViewController = UIHostingController(rootView: self)
        hostingViewController.navigationItem.hidesBackButton = false
        hostingViewController.modalPresentationStyle = .overFullScreen
        hostingViewController.modalTransitionStyle = .crossDissolve
        hostingViewController.view.backgroundColor = .clear
        
        sourceViewController.present(hostingViewController, animated: false)
    }
}

#Preview {
    ToolTipView()
}
