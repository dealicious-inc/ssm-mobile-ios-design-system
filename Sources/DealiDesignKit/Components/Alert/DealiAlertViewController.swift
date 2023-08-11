//
//  DealiAlert.swift
//  
//
//  Created by hoji on 2023/08/09.
//

import UIKit

final class DealiAlert: NSObject {
    class func show(title: String? = nil, message: String, cancelButtonTitle: String? = nil, confirmButtonTitle: String? = nil, closeAlertOnOutsideTouch: Bool = true, cancelAndCloseOnOutsideTouch: Bool = false, alertPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) {
        
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
    private let titleLabel = UILabel()
    
    private let messageContentStackView = UIStackView()
    private let messageLabel = UILabel()
    
    private let cancelButton = DealiButton()
    private let confirmButton = DealiButton()
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    
    var alertTitle: String? {
        didSet {
            if let title = self.alertTitle {
                self.titleLabel.isHidden = false
                self.titleLabel.text = title
            } else {
                self.titleLabel.isHidden = true
            }
        }
    }
    
    var alertMessage: NSMutableAttributedString? {
        didSet {
            if let message = self.alertMessage {
                self.messageLabel.attributedText = message
            }
        }
    }
    
    var cancelButtonTitle: String? {
        didSet {
            if let buttontitle = self.cancelButtonTitle {
                self.cancelButton.isHidden = false
                self.cancelButton.title = buttontitle
            } else {
                self.cancelButton.isHidden = true
            }
        }
    }
    
    var confirmButtonTitle: String? {
        didSet {
            if let buttontitle = self.confirmButtonTitle {
                self.confirmButton.isHidden = false
                self.confirmButton.title = buttontitle
            } else {
                self.confirmButton.isHidden = true
            }
        }
    }
    /// content 영역 이외의 영역 터치시 alert닫기
    var closeAlertOnOutsideTouch: Bool = false
    /// content 영역 이외의 영턱 터치시 cancelAction 실행과 alert닫기
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
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10.0
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280.0)
            $0.height.lessThanOrEqualTo(456.0)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .sh1sb20
            $0.textColor = DealiColor.text01
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.text = "Temp Alert Title"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(24.0)
        }
        
        let buttonStackView = UIStackView()
        self.contentView.addSubview(buttonStackView)
        buttonStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(20.0)
        }
        
        buttonStackView.addArrangedSubview(self.cancelButton)
        self.cancelButton.then {
            $0.style = .medium(style: .outlined)
            $0.title = "취소"
            $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        buttonStackView.addArrangedSubview(self.confirmButton)
        self.confirmButton.then {
            $0.style = .medium(style: .filled)
            $0.title = "확인"
            $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        let messageContentScrollView = UIScrollView()
        self.contentView.addSubview(messageContentScrollView)
        messageContentScrollView.then {
            $0.bounces = false
            $0.showsVerticalScrollIndicator = false
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-24.0)
        }
        
        let messageContentView = UIView()
        messageContentScrollView.addSubview(messageContentView)
        messageContentView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        messageContentView.addSubview(self.messageContentStackView)
        self.messageContentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 6.0
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        self.messageContentStackView.addArrangedSubview(self.messageLabel)
        self.messageLabel.then {
            $0.font = .sh3r16
            $0.textColor = DealiColor.text03
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.text = "Temp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message\nTemp Alert Message"
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
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

extension UIViewController {
    private struct UIViewControllerPreview: UIViewControllerRepresentable {
        let viewController: UIViewController

                func makeUIViewController(context: Context) -> UIViewController {
                    return viewController
                }

                func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
                }
    }
    
    func showPreview() -> some View {
        UIViewControllerPreview(viewController: self)
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

