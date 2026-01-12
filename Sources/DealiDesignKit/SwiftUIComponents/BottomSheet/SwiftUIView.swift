//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 1/6/26.
//

import SwiftUI

/**
 설명: 바텀시트 상태관리
 */
public final class DealiSheetState: ObservableObject {
    @Published public var isPresented: Bool = false {
        didSet {
            if isPresented == false {
                onDismiss?()
            }
        }
    }
    
    public var onDismiss: (() -> Void)?
    
    public init(isPresented: Bool, onDismiss: (() -> Void)? = nil) {
        self.isPresented = isPresented
        self.onDismiss = onDismiss
    }
}

/**
 설명: 바텀시트 SwiftUI 컴포넌트
 */
public struct DealiSheetView<Content: View>: View {
    @EnvironmentObject var sheetState: DealiSheetState
    var title: String?
    var showCloseButton: Bool
    var heightRatio: CGFloat
    var fixedHeight: CGFloat
    var closeOnBackgroundTap: Bool
    var content: Content
    
    // MARK: - Init
    public init(
        title: String? = nil,
        showCloseButton: Bool = false,
        heightRatio: CGFloat = 0.8,
        fixedHeight: CGFloat = 0.0,
        closeOnBackgroundTap: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showCloseButton = showCloseButton
        self.heightRatio = heightRatio
        self.fixedHeight = fixedHeight
        self.closeOnBackgroundTap = closeOnBackgroundTap
        self.content = content()
    }
    
    // MARK: - View
    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                if sheetState.isPresented {
                    Color.b50
                        .onTapGesture {
                            if closeOnBackgroundTap {
                                withAnimation(.easeInOut(duration: 0.3)) { sheetState.isPresented = false }
                            }
                        }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.25), value: sheetState.isPresented)
                    
                    VStack(spacing: 0) {
                        if title != nil || showCloseButton {
                            titleView()
                        }
                        
                        content
                            .padding(.bottom, geo.safeAreaInsets.bottom)
                    }
                    .frame(width: geo.size.width)
                    .frame(maxHeight: calculatedHeight(for: geo.size.height))
                    .fixedSize()
                    .background(Color.primary04)
                    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                    .transition(.move(edge: .bottom))
                    .shadow(color: .black.opacity(0.12), radius: 8, y: -2)
                }
            }
            .ignoresSafeArea(edges: .all)
            .animation(.easeInOut(duration: 0.2), value: sheetState.isPresented)
        }
    }
    
    private func dismissSheet() {
        withAnimation(.easeInOut(duration: 0.3)) { sheetState.isPresented = false }
    }
}

private extension DealiSheetView {
    func titleView() -> some View {
        HStack {
            if let title {
                Text(title)
                    .font(.sh2sb18)
            }
            Spacer()
            if showCloseButton {
                Button(action: {
                    sheetState.isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .padding(8)
                }
            }
        }
        .foregroundStyle(Color.g100)
        .padding(.top, 24)
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
        .frame(height: 60)
    }
    
    func calculatedHeight(for totalHeight: CGFloat) -> CGFloat {
        fixedHeight > 0 ? fixedHeight : totalHeight * heightRatio
    }
}

#Preview {
    struct PreviewHost: View {
        @EnvironmentObject var sheetState: DealiSheetState
        
        var body: some View {
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 20) {
                        Text("메인 콘텐츠")
                            .font(.headline)
                        
                        Button("DealiSheetView 표시") {
                            sheetState.isPresented = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("프리뷰")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    DealiSheetView(
                        title: "옵션 선택",
                        showCloseButton: true
                    ) {
                        VStack {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(0..<2) { i in
                                        Text("옵션 \(i + 1)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, 8)
                                            .background(Color(uiColor: .systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                            
                            HStack(spacing: 8) {
                                ButtonView(type: .btnOutlineLarge01, title: "취소")
                                ButtonView(type: .btnFilledLarge01, title: "확인")
                            }
                            .frame(height: 50.0)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        }
                    }
                    .environmentObject(DealiSheetState())
                }
            }
        }
    }
    
    return PreviewHost()
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

