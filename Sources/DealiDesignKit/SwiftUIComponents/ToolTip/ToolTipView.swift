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
    
    public enum TailAlignment {
        case topLeft
        case bottomLeft
        case topCenter
        case bottomCenter
        case topRight
        case bottomRight
    }
    
    public enum ToolTipColor {
        case blue
        case white
    }
    
    private enum Constants {
        static let tailImageWidth: CGFloat = 12
        static let tailImageHeight: CGFloat = 6
        static let tailImageXOffset: CGFloat = -21
    }
    
    @State private var opacity = 0.0
    @State private var tooltipWidth: CGFloat = 0
    @State private var tooltipHeight: CGFloat = 0
    private var arrowPosition: TailAlignment = .topLeft
    private var targetFrame: CGRect = .zero
    private var text: String = ""
    private var color: ToolTipColor = .blue
    // padding
    
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
                    x: tooltipXOffset(),
                    y: tooltipYOffset()
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
        Text(text)
            .font(Font(UIFont.b3sb13))
            .foregroundColor(color.title())
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 6.0)
                    .fill(color.background())
            )
            .overlay(
                tailImage,
                alignment: arrowPosition.alignment()
            )
    }
    
    private var tailImage: some View {
        Image("img_tailanchor", bundle: .module)
            .resizable()
            .frame(width: Constants.tailImageWidth, height: Constants.tailImageHeight)
            .scaleEffect(x: 1, y: tailImageYScale())
            .offset(x: tailImageXOffset(), y: tailImageYOffset())
    }
    
    public init(isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
}

extension ToolTipView {
    public func targetFrame(_ targetView: UIView) -> Self {
        var copy = self
        copy.targetFrame = targetView.frame
        copy.targetFrame.origin.y -= (targetView.window?.safeAreaInsets.top ?? 0)
        return copy
    }
    
    public func arrowPosition(_ alignment: TailAlignment) -> Self {
        var copy = self
        copy.arrowPosition = alignment
        return copy
    }
    
    public func text(_ text: String) -> Self {
        var copy = self
        copy.text = text
        return copy
    }
    
    public func color(_ color: ToolTipColor) -> Self {
        var copy = self
        copy.color = color
        return copy
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

extension ToolTipView {
    private func viewAppear() {
        withAnimation(presentAnimation) { opacity = 1.0 }
    }
    
    private func viewDismiss() {
        withAnimation(dismissAnimation) { opacity = 0.0 }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration) {
            dismiss()
        }
    }
    
    private func tooltipXOffset() -> CGFloat {
        switch arrowPosition {
        case .topLeft, .bottomLeft:
            return targetFrame.midX - (tooltipWidth / 2) - Constants.tailImageXOffset
        case .topCenter, .bottomCenter:
            return targetFrame.midX - (tooltipWidth / 2)
        case .topRight, .bottomRight:
            return targetFrame.midX - (tooltipWidth / 2) + Constants.tailImageXOffset
        }
    }
    
    private func tooltipYOffset() -> CGFloat {
        switch arrowPosition {
        case .topLeft, .topCenter, .topRight:
            return targetFrame.maxY + Constants.tailImageHeight
        case .bottomLeft, .bottomCenter, .bottomRight:
            return targetFrame.minY - Constants.tailImageHeight - tooltipHeight
        }
    }
    
    private func tailImageXOffset() -> CGFloat {
        switch arrowPosition {
        case .topLeft, .bottomLeft:
            return -Constants.tailImageXOffset
        case .topCenter, .bottomCenter:
            return 0
        case .topRight, .bottomRight:
            return Constants.tailImageXOffset
        }
    }
    
    private func tailImageYOffset() -> CGFloat {
        switch arrowPosition {
        case .topLeft, .topCenter, .topRight:
            return -Constants.tailImageHeight
        case .bottomLeft, .bottomCenter, .bottomRight:
            return Constants.tailImageHeight
        }
    }
    
    private func tailImageYScale() -> CGFloat {
        switch arrowPosition {
        case .topLeft, .topCenter, .topRight:
            return -1
        case .bottomLeft, .bottomCenter, .bottomRight:
            return 1
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
        case .topLeft: return .topLeading
        case .bottomLeft: return.bottomLeading
        case .topCenter: return .top
        case .bottomCenter: return .bottom
        case .topRight: return .topTrailing
        case .bottomRight: return .bottomTrailing
        }
    }
}

private extension ToolTipView.ToolTipColor {
    func background() -> Color {
        switch self {
        case .blue: return Color(uiColor: .secondary01)
        case .white: return Color(uiColor: .primary04)
        }
    }
    
    func title() -> Color {
        switch self {
        case .blue: return Color(uiColor: .primary04)
        case .white: return Color(uiColor: .g100)
        }
    }
}

#Preview {
    ToolTipView()
}
