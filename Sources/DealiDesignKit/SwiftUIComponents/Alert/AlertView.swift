//
//  AlertView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/14/25.
//

import SwiftUI
import UIKit.UIViewController

public struct AlertView: View {
    /// For UIKit Base
    @Environment(\.dismiss) private var dismiss
    /// For Full SwiftUI Base
    @Binding var isPresented: Bool
    
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    
    @State private var backgroundOpacity = 0.0
    @State private var opacity = 0.0
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    final private class ViewModel: ObservableObject {
        @Published var title: String?
        @Published var message: String?
        
        @Published var confirmButtonTitle: String?
        var confirmButtonAction: () -> Void = {}
        
        @Published var cancelButtonTitle: String?
        var cancelButtonAction: () -> Void = {}
        
        var isFullSwiftUI: Bool = false
    }
    
    public var body: some View {
        ZStack{
            Color(.b40).opacity(opacity).ignoresSafeArea(.all)
            
            alertContainerView
                .padding(.horizontal, 40)
                .background(.clear)
                .frame(alignment: .center)
        }
        .onAppear { viewAppear() }
        .onTapGesture { viewDismiss() }
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
            if viewModel.isFullSwiftUI {
                // NavigationLink를 사용하지 않은 SwiftUI View에서 Alert노출 시, 하단 View가 함께 dismiss되어서 isPresented를 사용.
                isPresented = false
            } else {
                // UIKit에서는 하위 뷰 dismiss 처리
                dismiss()
            }
        }
    }
    
    public init(isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
    
    @ViewBuilder
    private var alertContainerView: some View {
        VStack {
            // Title
            if let title = viewModel.title, !title.isEmpty {
                Text(title)
                    .font(Font(UIFont.sh2sb18))
                    .foregroundStyle(Color(UIColor.g100))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10.0)
            }
            
            // Message
            if let message = viewModel.message, !message.isEmpty {
                Spacer().frame(height: 4.0)
                Text(message)
                    .font(Font(UIFont.sh3r16))
                    .foregroundStyle(Color(UIColor.g80))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer().frame(height: 24.0)
            
            // ChekBox
            HStack(spacing: 8.0) {
                
            }
            
            // Button
            HStack(spacing: 10.0) {
                if let cancelButtonTitle = viewModel.cancelButtonTitle {
                    ButtonView()
                        .setStyle(.btnOutlineMedium01)
                        .setTitle(cancelButtonTitle)
                        .addAction {
                            viewModel.cancelButtonAction()
                            viewDismiss()
                        }
                }
                
                if let confirmButtonTitle = viewModel.confirmButtonTitle {
                    ButtonView()
                        .setStyle(.btnFilledLarge01)
                        .setTitle(confirmButtonTitle)
                        .addAction {
                            viewModel.confirmButtonAction()
                            viewDismiss()
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 24.0)
        .padding(.bottom, 20.0)
        .padding(.horizontal, 20.0)
        .background(Color.white).opacity(opacity)
        .cornerRadius(10.0)
    }
    
}

// MARK: - Set ViewModel
public extension AlertView {
    func addTitle(_ title: String) -> Self {
        viewModel.title = title
        return self
    }
    
    func addMessage(_ message: String) -> Self {
        viewModel.message = message
        return self
    }
    
    func addConfirmButton(title: String, action: (() -> Void)? = nil) -> Self {
        viewModel.confirmButtonTitle = title
        if let action {
            viewModel.confirmButtonAction = action
        }
        return self
    }
    
    func addCancelButton(title: String, action: (() -> Void)? = nil) -> Self {
        viewModel.cancelButtonTitle = title
        if let action {
            viewModel.cancelButtonAction = action
        }
        return self
    }
    
    // SwiftUI View에서 화면 노출할때 구분하기 위해 사용
    func fullSwiftUI()  -> Self {
        self.viewModel.isFullSwiftUI = true
        return self
    }
    
    // UIKit에서 AlertView 노출 시 사용
    func show(_ sourceViewController: UIViewController) {
        let hostingViewController = UIHostingController(rootView: self)
        hostingViewController.navigationItem.hidesBackButton = false
        hostingViewController.modalPresentationStyle = .overFullScreen
        hostingViewController.modalTransitionStyle = .crossDissolve
        hostingViewController.view.backgroundColor = .clear
        
        sourceViewController.present(hostingViewController, animated: false)
    }
}

// MARK: - Preview
#Preview {
    AlertView(isPresented: .constant(true))
}

