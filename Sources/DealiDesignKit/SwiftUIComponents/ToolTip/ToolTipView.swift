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
    @State private var tooltipWidth: CGFloat = 0
    @State private var tooltipHeight: CGFloat = 0
    
    public enum TailAlignment {
        case left
        case center
        case right
    }
    
    private enum Constants {
        static let tailImageWidth: CGFloat = 12
        static let tailImageHeight: CGFloat = 6
        static let tailImageXOffset: CGFloat = -21
        static let tailImageYOffset: CGFloat = -6
    }
    
    private var targetFrame: CGRect = .zero
    @State private var tailAlignment: TailAlignment = .right
    private var text: String = ""
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear  // 투명한 배경을 전체 화면에 깔아줌 (탭 인식용)
                .contentShape(Rectangle()) // 터치 영역 명시
                .ignoresSafeArea()
                .onTapGesture { viewDismiss() }
            tooltipText
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: TooltipSizeKey.self, value: CGSize(width: geo.size.width, height: geo.size.height))
                    }
                )
                .offset(
                    x: tooltipXOffset(),//targetFrame.midX - (tooltipWidth + Constants.tailImageXOffset),
                    y: targetFrame.maxY + Constants.tailImageHeight//targetFrame.maxY + Constants.tailImageYOffset - (tooltipHeight / 2)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(opacity)
        .onAppear { viewAppear() }
        .onPreferenceChange(TooltipSizeKey.self) { size in
            self.tooltipWidth = size.width
            self.tooltipHeight = size.height
        }
    }
    
    private var tooltipText: some View {
//                Text("최근의 상품 찜수 등의 정보를\n종합하여 지금 보고 계신 매장의\n오늘 인기 있는 상품을 알려드려요")
        Text(text)
            .font(Font(UIFont.b3sb13))
            .foregroundColor(.white)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 6.0)
                    .fill(Color(UIColor.secondary01))
            )
            .overlay(
                tailImage,
                alignment: tailAlignment.alignment()
            )
    }
    
    public init(isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
    
    @ViewBuilder
    private var tailImage: some View {
        Image("img_tailanchor", bundle: .module)
            .resizable()
            .frame(width: Constants.tailImageWidth, height: Constants.tailImageHeight)
            .scaleEffect(x: 1, y: -1)
//            .offset(x: Constants.tailImageXOffset, y: Constants.tailImageYOffset)
            .offset(x: tailImageXOffset(), y: Constants.tailImageYOffset)
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
    
    public func setTargetFrame(_ targetView: UIView) -> Self {
        var copy = self
        copy.targetFrame = targetView.frame
        copy.targetFrame.origin.y -= (targetView.window?.safeAreaInsets.top ?? 0)//targetView.convert(targetView.bounds, to: targetView.window)
        return copy
    }
    
    public func setArrowPosition(_ alignment: TailAlignment) -> Self {
        var copy = self
        copy._tailAlignment = State(initialValue: alignment)
        return copy
    }
    
    public func setText(_ text: String) -> Self {
        var copy = self
        copy.text = text
        return copy
    }
    
    private func tooltipXOffset() -> CGFloat {
        switch tailAlignment {
        case .left:
            return targetFrame.minX - Constants.tailImageXOffset
        case .center:
            return targetFrame.midX - (tooltipWidth / 2)
        case .right:
            return targetFrame.midX - (tooltipWidth + Constants.tailImageXOffset)
        }
    }
    
    private func tailImageXOffset() -> CGFloat {
        switch tailAlignment {
        case .left:
            return -Constants.tailImageXOffset//Constants.tailImageWidth / 2
        case .center:
            return 0
        case .right:
            return Constants.tailImageXOffset
        }
    }
}

private struct TooltipSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private extension ToolTipView.TailAlignment {
    func alignment() -> Alignment {
        switch self {
        case .left: return .topLeading
        case .center: return .top
        case .right: return .topTrailing
        }
    }
}

#Preview {
    ToolTipView()
}
