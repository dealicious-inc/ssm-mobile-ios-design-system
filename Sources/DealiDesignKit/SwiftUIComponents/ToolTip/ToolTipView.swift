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
    
    private var targetFrame: CGRect = .zero
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    public var body: some View {
        ZStack {
            Color.clear  // 투명한 배경을 전체 화면에 깔아줌 (탭 인식용)
                .contentShape(Rectangle()) // 터치 영역 명시
                .ignoresSafeArea()
                .onTapGesture { viewDismiss() }
            
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
                .offset(
                    x: targetFrame.origin.x,
                    y: targetFrame.origin.y + targetFrame.height + 8 // 기준 뷰 아래로 툴팁 배치
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(opacity)
        .onAppear { viewAppear() }
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
        
//        guard let window = targetView.window else { return }

        // 기준 뷰의 화면 내 절대 좌표 계산
//        let targetFrame = targetView.convert(targetView.bounds, to: window)
    }
    
    public func setTargetFrame(_ targetView: UIView) -> Self {
        var copy = self
        copy.targetFrame = targetView.frame//targetView.convert(targetView.bounds, to: targetView.window)
        return copy
    }
}

#Preview {
    ToolTipView()
}
