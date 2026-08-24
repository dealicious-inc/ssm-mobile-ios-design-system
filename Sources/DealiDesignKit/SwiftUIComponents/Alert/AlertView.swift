//
//  AlertView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 2/14/25.
//

import SwiftUI
import UIKit.UIViewController

public struct AlertButton {
    public let title: String
    public let action: () -> Void

    public init(
        title: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.action = action
    }
}

/**
 설명: Alert 취소/확인 버튼의 스타일을 정하는 값
 */
public struct AlertButtonStyle {
    /// 취소 버튼 스타일
    public var cancel: ButtonView.ButtonConfigStyle
    /// 확인 버튼 스타일
    public var confirm: ButtonView.ButtonConfigStyle
    
    public init(cancel: ButtonView.ButtonConfigStyle = .btnOutlineMedium01,
                confirm: ButtonView.ButtonConfigStyle = .btnFilledLarge01) {
        self.cancel = cancel
        self.confirm = confirm
    }
    
    /// 디자인시스템 기본 스타일
    public static let `default` = AlertButtonStyle()
}

public struct AlertViewModel {
    public var title: String?
    public var message: String?
    public var checkbox: CheckboxView?
    public var confirm: AlertButton?
    public var cancel: AlertButton?
    public var buttonStyle: AlertButtonStyle

    public init(
        title: String? = nil,
        message: String,
        checkbox: CheckboxView? = nil,
        confirm: AlertButton? = nil,
        cancel: AlertButton? = nil,
        buttonStyle: AlertButtonStyle = .default
    ) {
        self.title = title
        self.message = message
        self.checkbox = checkbox
        self.confirm = confirm
        self.cancel = cancel
        self.buttonStyle = buttonStyle
    }
}

public struct AlertView: View {
    /// For UIKit Base
    @Environment(\.dismiss) private var dismiss
    /// For Full SwiftUI Base
    @Binding var isPresented: Bool
    
    let viewModel: AlertViewModel
    var isFullSwiftUI: Bool = false
    
    @State private var backgroundOpacity = 0.0
    @State private var opacity = 0.0
    
    private let animateDuration: CGFloat = 0.2
    public var presentAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    public var dismissAnimation: Animation {
        Animation.easeOut(duration: Double(animateDuration))
    }
    
    public init(title: String? = nil,
                message: String,
                checkbox: CheckboxView? = nil,
                confirm: AlertButton? = nil,
                cancel: AlertButton? = nil,
                buttonStyle: AlertButtonStyle = .default) {
        let viewModel = AlertViewModel(title: title,
                                       message: message,
                                       checkbox: checkbox,
                                       confirm: confirm,
                                       cancel: cancel,
                                       buttonStyle: buttonStyle)
        self.init(viewModel: viewModel)
    }
    
    public init(isPresented: Binding<Bool> = .constant(true),
                viewModel: AlertViewModel,
                isFullSwiftUI: Bool = false) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.isFullSwiftUI = isFullSwiftUI
    }
    
    public var body: some View {
        ZStack{
            Color(.b40)
                .opacity(opacity)
                .ignoresSafeArea()
                .onTapGesture { dismissAlert() }
            
            alertContent
                .frame(maxWidth: DealiAlertBaseViewController.maxContentWidth)
                .padding(.horizontal, DealiAlertBaseViewController.contentHorizontalPadding)
        }
        .onAppear { showAlert() }
    }
    
    @ViewBuilder
    private var alertContent: some View {
        VStack {
            titleText
            messageText
            checkbox
            buttonContainer
        }
        .padding(.top, 24.0)
        .padding(.bottom, 20.0)
        .padding(.horizontal, 20.0)
        .background(Color.white).opacity(opacity)
        .cornerRadius(10.0)
    }
    
    @ViewBuilder
    private var titleText: some View {
        if let title = viewModel.title, !title.isEmpty {
            Text(title.byCharWrapping)
                .font(Font(UIFont.sh2sb18))
                .foregroundStyle(Color(UIColor.g100))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 10.0)
        }
    }
    
    @ViewBuilder
    private var messageText: some View {
        if let message = viewModel.message, !message.isEmpty {
            Spacer().frame(height: 4.0)
            Text(message.byCharWrapping)
                .font(Font(UIFont.sh3r16))
                .foregroundStyle(Color(UIColor.g80))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var checkbox: some View {
        if let checkbox = viewModel.checkbox {
            Spacer().frame(height: 16.0)
            checkbox
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var buttonContainer: some View {
        Spacer().frame(height: 24.0)
        HStack(spacing: 10.0) {
            if let cancel = viewModel.cancel {
                ButtonView(type: viewModel.buttonStyle.cancel,
                           title: cancel.title) {
                    cancel.action()
                    dismissAlert()
                }
            }
            
            if let confirm = viewModel.confirm {
                ButtonView(type: viewModel.buttonStyle.confirm,
                           title: confirm.title) {
                    confirm.action()
                    dismissAlert()
                }
            }
        }
    }
}

extension AlertView {
    private func showAlert() {
        withAnimation(presentAnimation) {
            opacity = 1.0
        }
    }
    
    private func dismissAlert() {
        withAnimation(dismissAnimation) {
            opacity = 0.0
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration) {
            if isFullSwiftUI {
                // NavigationLink를 사용하지 않은 SwiftUI View에서 Alert노출 시, 하단 View가 함께 dismiss되어서 isPresented를 사용.
                isPresented = false
            } else {
                // UIKit에서는 하위 뷰 dismiss 처리
                dismiss()
            }
//        }
    }
    
    // UIKit에서 AlertView 노출 시 사용
    public func show(_ sourceViewController: UIViewController) {
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
    AlertView(
        isPresented: .constant(true),
        viewModel: .init(title: "타이틀", message: "메세지", confirm: .init(title: "확인"), cancel: .init(title: "취소"))
    )
}

