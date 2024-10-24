//
//  DealiAlert.swift
//  
//
//  Created by hoji on 2023/08/14.
//

import UIKit

/**
 디자인시스템 Alert 적용
 현제는 기본적으로 Title, Massge, 취소, 확인버튼만 존제하는 기본 Alert
 content 영역 이외의 영역 터치시 alert닫기 위해서는 closeAlertOnOutsideTouch = true 로 설정
 content 영역 이외의 영턱 터치시 cancelAction 실행과 alert닫기 cancelAndCloseOnOutsideTouch = true 로 설정
 
 버튼 Title 유무에 따라 1버튼 ,2버튼 처리
 */

public class DealiAlert: NSObject {
    
    /// 외부에서 alert을 닫을때 사용되는 botification name
    static public let closeNotificationName = Notification.Name("DealiAlertClose")
    
    // 1버튼 확인 버튼
    public class func showConfirm(title: String? = nil, message: String, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, confirmAction: (() -> Swift.Void)?) {
        
        self.show(title: title,
                  message: message,
                  cancelButtonTitle: nil,
                  confirmButtonTitle: confirmButtonTitle,
                  closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                  cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                  alertPresentingViewController: alertPresentingViewController,
                  cancelAction: nil,
                  confirmAction: confirmAction)
    }
    
    // 1버튼 확인 버튼
    public class func showCheckBox(title: String? = nil, message: String, checkButtonTitle: String, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: ((Bool) -> Swift.Void)?) {
        
        let checkBoxContainerView = UIView()
        
        let checkBoxView = DealiCheckboxWithText()
        checkBoxContainerView.addSubview(checkBoxView)
        checkBoxView.then {
            $0.text = checkButtonTitle
            $0.font = .b2r14
            $0.status = .init()
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.show(title: title,
                  message: message,
                  insertCustomView: checkBoxContainerView,
                  cancelButtonTitle: cancelButtonTitle,
                  confirmButtonTitle: confirmButtonTitle,
                  closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                  cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                  alertPresentingViewController: alertPresentingViewController,
                  cancelAction: cancelAction) {
            guard let action = confirmAction else { return }
            action(checkBoxView.isSelected)
            
        }
    }
    
    public class func show(title: String? = nil, message: String, insertCustomView: UIView? = nil, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, audoDismissDuration: CGFloat? = nil, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) {
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.alignment = .left
        messageStyle.lineHeightMultiple = 1.16
        let font = UIFont.sh3r16
        var baselineOffset = ((font.lineHeight * messageStyle.lineHeightMultiple) - font.lineHeight) / 4
        if #available(iOS 16.4, *) {
            baselineOffset = ((font.lineHeight * messageStyle.lineHeightMultiple) - font.lineHeight) / 2
        }
        
        self.showAttributedMessage(title: title,
                                   message: NSMutableAttributedString(string: message, attributes: [.font: font, .foregroundColor: DealiColor.g80, .paragraphStyle: messageStyle, .baselineOffset: baselineOffset]),
                                   insertCustomView: insertCustomView,
                                   cancelButtonTitle: cancelButtonTitle,
                                   confirmButtonTitle: confirmButtonTitle,
                                   closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                                   cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                                   audoDismissDuration: audoDismissDuration,
                                   alertPresentingViewController: alertPresentingViewController,
                                   cancelAction: cancelAction,
                                   confirmAction: confirmAction)
        
    }
    
    public class func showAttributedMessage(title: String? = nil, message: NSMutableAttributedString?, insertCustomView: UIView? = nil, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, audoDismissDuration: CGFloat? = nil, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) {
        
        let alertViewController = DealiAlertViewController()
        if let title = title {
            let titleStyle = NSMutableParagraphStyle()
            titleStyle.alignment = .left
            titleStyle.lineHeightMultiple = 1.21
            let font = UIFont.sh2sb18
            var baselineOffset = ((font.lineHeight * titleStyle.lineHeightMultiple) - font.lineHeight) / 4
            if #available(iOS 16.4, *) {
                baselineOffset = ((font.lineHeight * titleStyle.lineHeightMultiple) - font.lineHeight) / 2
            }
            
            alertViewController.alertTitle = NSMutableAttributedString(string: title, attributes: [.font: font, .foregroundColor: DealiColor.g100, .paragraphStyle: titleStyle, .baselineOffset: baselineOffset])
        }
        
        alertViewController.alertMessage = message
        alertViewController.insertCustomView = insertCustomView
        alertViewController.cancelButtonTitle = cancelButtonTitle
        alertViewController.confirmButtonTitle = confirmButtonTitle
        alertViewController.closeAlertOnOutsideTouch = closeAlertOnOutsideTouch
        alertViewController.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
        alertViewController.cancelAction = cancelAction
        alertViewController.confirmAction = confirmAction
        
        alertPresentingViewController.present(alertViewController, animated: true)
        
        if let audoDismissDuration, audoDismissDuration > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + audoDismissDuration) { [weak alertViewController] in
                alertViewController?.dismiss(animated: true)
            }
        }
    }
    
}

final class DealiAlertViewController: UIViewController {
    
    private let contentView = UIView()
    private let contentStackView = UIStackView()
    
    private let messageContentScrollView = UIScrollView()
    private let messageContentStackView = UIStackView()
    private let messageLabel = UILabel()
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    
    var alertTitle: NSMutableAttributedString?
    var alertMessage: NSMutableAttributedString?
    var insertCustomView: UIView?
    var cancelButtonTitle: String?
    var confirmButtonTitle: String?
    /// content이외 영영 터치로 alert을 닫을지 유무
    var closeAlertOnOutsideTouch: Bool = false
    /// content이외 영영 터치로 alert을 닫을때 cancel action을 호출할지 유무
    var cancelActionOnOutsideTouch: Bool = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = DealiColor.b40
        /// 외부에서 DealiAlert을 닫아야 하는 경우 호출
        NotificationCenter.default.addObserver(self, selector: #selector(closeAction(_:)), name: DealiAlert.closeNotificationName, object: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        let isAlerttitleContentExposure: Bool = (self.alertTitle != nil)
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10.0
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
//            $0.width.equalTo(280.0)
            $0.left.right.equalToSuperview().inset(40.0)
        }
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 14.0
            $0.alignment = .fill
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset((isAlerttitleContentExposure ? 24.0 : 28.0))
            $0.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        if isAlerttitleContentExposure {
            let titleContainerStackView = UIStackView()
            contentStackView.addArrangedSubview(titleContainerStackView)
            titleContainerStackView.then {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.distribution = .fill
                $0.spacing = 16.0
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            let titleLabel = UILabel()
            titleContainerStackView.addArrangedSubview(titleLabel)
            titleLabel.then {
                $0.numberOfLines = 0
                $0.attributedText = alertTitle
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
        
        self.contentStackView.addArrangedSubview(self.messageContentScrollView)
        self.messageContentScrollView.then {
            $0.bounces = false
            $0.showsVerticalScrollIndicator = false
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.0)
        }
        
        self.messageContentScrollView.addSubview(self.messageContentStackView)
        self.messageContentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.messageContentStackView.addArrangedSubview(self.messageLabel)
        self.messageLabel.then {
            $0.numberOfLines = 0
            $0.attributedText = alertMessage
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        if let insertCustomView = self.insertCustomView {
            self.messageContentStackView.addArrangedSubview(insertCustomView)
            insertCustomView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        let buttonContainerView = UIView()
        self.contentStackView.addArrangedSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let buttonStackView = UIStackView()
        buttonContainerView.addSubview(buttonStackView)
        buttonStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
        if let cancelButtonTitle = self.cancelButtonTitle {
            let cancelButton = DealiControl.btnOutlineMedium01()
            buttonStackView.addArrangedSubview(cancelButton)
            cancelButton.then {
                $0.title = cancelButtonTitle
                $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
        
        if let confirmButtonTitle = self.confirmButtonTitle {
            let confirmButton = DealiControl.btnFilledMedium01()
            buttonStackView.addArrangedSubview(confirmButton)
            confirmButton.then {
                $0.title = confirmButtonTitle
                $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 스크롤뷰 사이즈 조정
        if self.messageContentStackView.subviews.count > 0 {
            self.messageContentScrollView.layoutIfNeeded()
            var contentHeight: CGFloat = self.messageContentScrollView.contentSize.height
            /// 화면의 70% 높이를 alert max height로 설정
            let alertMaxHeight = (UIScreen.main.bounds.size.height * 0.7)
            if contentHeight > alertMaxHeight {
                contentHeight = alertMaxHeight
            }
            self.messageContentScrollView.snp.updateConstraints {
                $0.height.equalTo(contentHeight)
            }
        }
        
    }
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            if let self = self, let action = self.cancelAction {
                action()
            }
        }
    }
    
    @objc func confirmButtonAction() {
        self.dismiss(animated: true) { [weak self] in
            if let self = self, let action = self.confirmAction {
                action()
            }
        }
    }
    
    /// 외부에서 DealiAlert을 닫을때 호출되는 함수
    @objc func closeAction(_ notification: NSNotification) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closeAlertOnOutsideTouch == true  else { return }
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: DealiAlert.closeNotificationName, object: nil)
    }
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct AlertPreview: PreviewProvider {
//    static var previews: some View {
//        DealiAlertViewController().showPreview()
//    }
//}
//#endif
