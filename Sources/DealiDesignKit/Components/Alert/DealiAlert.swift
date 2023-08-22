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
    public class func showConfirm(title: String? = nil, message: String, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelAndCloseOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, confirmAction: (() -> Swift.Void)?) {
        
        self.show(title: title,
                  message: message,
                  cancelButtonTitle: nil,
                  confirmButtonTitle: confirmButtonTitle,
                  closeAlertOnOutsideTouch: closeAlertOnOutsideTouch,
                  cancelAndCloseOnOutsideTouch: cancelAndCloseOnOutsideTouch,
                  alertPresentingViewController: alertPresentingViewController,
                  cancelAction: nil,
                  confirmAction: confirmAction)
    }
    
    public class func show(title: String? = nil, message: String, cancelButtonTitle: String?, confirmButtonTitle: String?, closeAlertOnOutsideTouch: Bool = true, cancelAndCloseOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4.0
        style.alignment = .left
        
        let atMessage = NSMutableAttributedString(string: message, attributes: [.font: UIFont.sh3r16, .foregroundColor: DealiColor.text03, .paragraphStyle: style])
        
        
        let alertViewController = DealiAlertViewController()
        alertViewController.alertTitle = title
        alertViewController.alertMessage = atMessage
        alertViewController.cancelButtonTitle = cancelButtonTitle
        alertViewController.confirmButtonTitle = confirmButtonTitle
        alertViewController.closeAlertOnOutsideTouch = closeAlertOnOutsideTouch
        alertViewController.cancelAndCloseOnOutsideTouch = cancelAndCloseOnOutsideTouch
        alertViewController.cancelAction = cancelAction
        alertViewController.confirmAction = confirmAction
        
        alertPresentingViewController.present(alertViewController, animated: true)
    }
    
}

final class DealiAlertViewController: UIViewController {
    
    private let contentView = UIView()
    private let contentStackView = UIStackView()
    
    lazy private var titleLabel = UILabel()
    lazy private var cancelButton = DealiButton()
    lazy private var confirmButton = DealiButton()
    
    private let messageContentScrollView = UIScrollView()
    private let messageContentStackView = UIStackView()
    private let messageLabel = UILabel()
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    
    var alertTitle: String?
    var alertMessage: NSMutableAttributedString?
    var cancelButtonTitle: String?
    var confirmButtonTitle: String?
    var closeAlertOnOutsideTouch: Bool = false
    var cancelAndCloseOnOutsideTouch: Bool = false
    
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

        self.view.backgroundColor = DealiColor.etc06
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
            $0.width.equalTo(280.0)
        }
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 24.0
            $0.alignment = .fill
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset((isAlerttitleContentExposure ? 20.0 : 28.0))
            $0.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        if isAlerttitleContentExposure {
            self.contentStackView.addArrangedSubview(self.titleLabel)
            self.titleLabel.then {
                $0.font = .sh1sb20
                $0.textColor = DealiColor.text01
                $0.textAlignment = .left
                $0.numberOfLines = 0
                $0.text = self.alertTitle
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            self.contentStackView.setCustomSpacing(20.0, after: self.titleLabel)
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
            $0.spacing = 6.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.messageContentStackView.addArrangedSubview(self.messageLabel)
        self.messageLabel.then {
            $0.font = .sh3r16
            $0.textColor = DealiColor.text03
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.attributedText = self.alertMessage
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let buttonStackView = UIStackView()
        self.contentStackView.addArrangedSubview(buttonStackView)
        buttonStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        if let cancelButtonTitle = self.cancelButtonTitle {
            buttonStackView.addArrangedSubview(self.cancelButton)
            self.cancelButton.then {
                $0.style = .medium(style: .outlined)
                $0.title = cancelButtonTitle
                $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
        
        if let confirmButtonTitle = self.confirmButtonTitle {
            buttonStackView.addArrangedSubview(self.confirmButton)
            self.confirmButton.then {
                $0.style = .medium(style: .filled)
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
            if contentHeight > 306 {
                contentHeight = 306
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false  else { return }
        if self.closeAlertOnOutsideTouch == true {
            self.dismiss(animated: true, completion: nil)
        } else {
            if self.cancelAndCloseOnOutsideTouch == true {
                self.cancelButtonAction()
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct AlertPreview: PreviewProvider {
    static var previews: some View {
        DealiAlertViewController().showPreview()
    }
}
#endif
