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
    
    // 1버튼 확인 버튼
    @discardableResult
    public class func showConfirm(title: String? = nil, message: String, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, confirmAction: (() -> Swift.Void)?) -> DealiAlertViewController {
        
        return self.show(title: title,
                         message: message,
                         cancelButtonTitle: nil,
                         confirmButtonTitle: confirmButtonTitle,
                         closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                         cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                         alertPresentingViewController: alertPresentingViewController,
                         cancelAction: nil,
                         confirmAction: confirmAction)
    }
    
    // 체크박스가 포함된 alert case
    @discardableResult
    public class func showCheckBox(title: String? = nil, message: String, checkButtonTitle: String, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: ((Bool) -> Swift.Void)?) -> DealiAlertViewController {
        
        let checkBoxContainerView = UIView()
        
        let checkBoxView = DealiCheckboxWithText()
        checkBoxContainerView.addSubview(checkBoxView)
        checkBoxView.then {
            $0.text = checkButtonTitle
            $0.font = .b2r14
            $0.status = .init()
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        return self.show(title: title,
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
    
    // textLinkButton이 포함된 alert case
    @discardableResult
    public class func showTextLink(title: String? = nil, message: String, textLinkButtonTitle: String, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?, textLinkAction: (() -> Swift.Void)?) -> DealiAlertViewController {
        
        let textLinkContainerView = UIView()
        
        let textLinkButton = DealiControl.textLinkLineSmall03()
        textLinkContainerView.addSubview(textLinkButton)
        textLinkButton.then {
            $0.title = textLinkButtonTitle
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        let alertViewController = self.show(title: title,
                                            message: message,
                                            insertCustomView: textLinkContainerView,
                                            cancelButtonTitle: cancelButtonTitle,
                                            confirmButtonTitle: confirmButtonTitle,
                                            closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                                            cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                                            alertPresentingViewController: alertPresentingViewController,
                                            cancelAction: cancelAction,
                                            confirmAction: confirmAction)
        
        textLinkButton.addAction(UIAction { _ in
            guard let action = textLinkAction else { return }
            alertViewController.hideAlert(hideHandler: {
                action()
            })
        }, for: .touchUpInside)
        
        return alertViewController
        
    }
    
    @discardableResult
    public class func show(title: String? = nil, message: String? = nil, insertCustomView: UIView? = nil, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, audoDismissDuration: CGFloat? = nil, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) -> DealiAlertViewController {
        
        var messageAttString: NSMutableAttributedString?
        if let message = message, message.trimming().isEmpty == false {
            messageAttString = NSMutableAttributedString(string: message)
                .font(.b1r15)
                .color(title == nil ? .g80 : .g70)
                .alignment(.left)
                .setLineHeight()
        }
        
        return self.showAttributedMessage(title: title,
                                          message: messageAttString,
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
    
    @discardableResult
    public class func showAttributedMessage(title: String? = nil, message: NSMutableAttributedString?, insertCustomView: UIView? = nil, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, audoDismissDuration: CGFloat? = nil, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) -> DealiAlertViewController {
        
        let alertViewController = DealiAlertViewController()
        if let title = title {
            alertViewController.alertTitle = NSMutableAttributedString(string: title)
                .font(.sh2sb18)
                .color(.g100)
                .alignment(.left)
                .setLineHeight()
        }
        
        alertViewController.message = message
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
                alertViewController?.hideAlert()
            }
        }
        
        return alertViewController
    }
    
}

open class DealiAlertViewController: DealiAlertBaseViewController {
    
    var alertTitle: NSMutableAttributedString?
    var message: NSMutableAttributedString?
    var insertCustomView: UIView?
    var cancelButtonTitle: String?
    var confirmButtonTitle: String?
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    
    private let messageScrollView = UIScrollView()
    private let messageLabel = UILabel()
    
    private let buttonStackView = UIStackView()
    
    /// 타이틀 영역 노출여부
    public var shouldExposeTitle: Bool = false
    /// 메세지 영역 노출여부
    public var shouldExposeMessage: Bool = false
    /// 확인버튼 노출여부
    public var shouldExposeConfirmButton: Bool = false
    /// 취소버튼 노출여부
    public var shouldExposeCancelButton: Bool = false
    
    /// 타이틀영역 높이
    public var titleContentHeight: CGFloat = 26.0
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func loadView() {
        super.loadView()
        
        self.shouldExposeTitle = (self.alertTitle != nil)
        self.shouldExposeMessage = (self.message != nil)
        
        self.shouldExposeConfirmButton = (self.confirmButtonTitle != nil && (self.confirmButtonTitle ?? "").trimming().isEmpty == false)
        self.shouldExposeCancelButton = (self.cancelButtonTitle != nil && (self.cancelButtonTitle ?? "").trimming().isEmpty == false)
        
        /// 타이틀이 있을때와 없을때 top padding값이 서로 다름
        self.contentStackView.snp.updateConstraints {
            $0.top.equalToSuperview().offset((self.shouldExposeTitle == true ? 24.0 : 28.0))
        }
        
        if self.shouldExposeTitle {
            let titleLabel = UILabel()
            self.contentStackView.addArrangedSubview(titleLabel)
            titleLabel.then {
                $0.numberOfLines = 0
                $0.attributedText = alertTitle
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            self.contentStackView.setCustomSpacing(14.0, after: titleLabel)
        }
        
        if self.shouldExposeMessage {
            self.contentStackView.addArrangedSubview(self.messageScrollView)
            self.messageScrollView.then {
                $0.bounces = false
                $0.showsVerticalScrollIndicator = false
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                
            }
            
            self.messageScrollView.addSubview(self.messageLabel)
            self.messageLabel.then {
                $0.numberOfLines = 0
                $0.attributedText = self.message
            }.snp.makeConstraints {
                $0.top.left.right.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
        if let insertCustomView = self.insertCustomView {
            if self.shouldExposeMessage {
                self.contentStackView.setCustomSpacing(16.0, after: self.messageScrollView)
            }
            
            self.contentStackView.addArrangedSubview(insertCustomView)
            insertCustomView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            self.contentStackView.setCustomSpacing(24.0, after: insertCustomView)
            
        } else {
            self.contentStackView.setCustomSpacing(24.0, after: self.messageScrollView)
        }
        
        if self.shouldExposeConfirmButton || self.shouldExposeCancelButton {
            self.contentStackView.addArrangedSubview(self.buttonStackView)
            self.buttonStackView.then {
                $0.axis = .horizontal
                $0.alignment = .fill
                $0.distribution = .fillEqually
                $0.spacing = 8.0
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            if self.shouldExposeCancelButton {
                let cancelButton = DealiControl.btnOutlineMedium01()
                self.buttonStackView.addArrangedSubview(cancelButton)
                cancelButton.then {
                    $0.title = self.cancelButtonTitle
                    $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
            }
            
            if self.shouldExposeConfirmButton {
                let confirmButton = DealiControl.btnFilledMedium01()
                self.buttonStackView.addArrangedSubview(confirmButton)
                confirmButton.then {
                    $0.title = self.confirmButtonTitle
                    $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
            }
        }
    }
    
    @objc func cancelButtonAction() {
        self.hideAlert {
            if let action = self.cancelAction {
                action()
            }
        }
    }
    
    @objc func confirmButtonAction() {
        self.hideAlert {
            if let action = self.confirmAction {
                action()
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closeAlertOnOutsideTouch == true else { return }
        
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hideAlert()
        }
    }
    
    open override func updateContainerViewHeight() {
        
        self.view.layoutIfNeeded()
        
        let titleContentHeight = (self.shouldExposeTitle == false ? 0.0 :( self.titleContentHeight + 14.0))
        let buttonContentHeight = ((self.shouldExposeCancelButton == true || self.shouldExposeConfirmButton == true) ? (self.buttonStackView.bounds.size.height + 24.0) : 0.0)
        
        var customViewheight = 0.0
        if let insertCustomView = self.insertCustomView {
            customViewheight = (insertCustomView.bounds.height + (self.shouldExposeMessage == true ? 16.0 : 0.0))
        }
        
        self.totalFixedContentHeight = (titleContentHeight + buttonContentHeight + customViewheight)
        
        super.updateContainerViewHeight()
    }
}
