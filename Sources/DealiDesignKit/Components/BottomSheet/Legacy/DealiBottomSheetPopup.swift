//
//  DealiBottomSheetPopup.swift
//
//
//  Created by hoji on 2023/11/21.
//

import UIKit

@available(*, deprecated)
public class DealiBottomSheetPopup: NSObject {
    
    // 1버튼 확인 버튼
    public class func showConfirm(title: String? = nil, message: String? = nil, confirmButtonTitle: String?, closePopupOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, isCloseButtonExposure: Bool = true, popupPresentingViewController: UIViewController, confirmAction: (() -> Swift.Void)?) {
        
        self.show(title: title,
                  message: message,
                  cancelButtonTitle: nil,
                  confirmButtonTitle: confirmButtonTitle,
                  closePopupOnOutsideTouch: closePopupOnOutsideTouch,
                  cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                  isCloseButtonExposure: isCloseButtonExposure,
                  popupPresentingViewController: popupPresentingViewController,
                  cancelAction: nil,
                  confirmAction: confirmAction)
    }

    public class func show(title: String? = nil, message: String? = nil, insertCustomView: UIView? = nil, cancelButtonTitle: String?, confirmButtonTitle: String?, closePopupOnOutsideTouch: Bool = true, cancelActionOnOutsideTouch: Bool = false, isCloseButtonExposure: Bool = true, popupPresentingViewController: UIViewController, cancelAction: (() -> Swift.Void)?, confirmAction: (() -> Swift.Void)?) {
        
        let bottomSheetPopupViewController = DealiBottomSheetPopupViewController()
        
        if let title = title {
            let titleStyle = NSMutableParagraphStyle()
            titleStyle.alignment = .left
            titleStyle.lineHeightMultiple = 1.21
            let font = UIFont.b2r14
            var baselineOffset = ((font.lineHeight * titleStyle.lineHeightMultiple) - font.lineHeight) / 4
            if #available(iOS 16.4, *) {
                baselineOffset = ((font.lineHeight * titleStyle.lineHeightMultiple) - font.lineHeight) / 2
            }
            
            bottomSheetPopupViewController.popupTitle = NSMutableAttributedString(string: title, attributes: [.font: font, .foregroundColor: UIColor.g100, .paragraphStyle: titleStyle, .baselineOffset: baselineOffset])
        }
        
        
        if let message = message {
            let messageStyle = NSMutableParagraphStyle()
            messageStyle.alignment = .left
            messageStyle.lineHeightMultiple = 1.16
            let font = UIFont.b2r14
            var baselineOffset = ((font.lineHeight * messageStyle.lineHeightMultiple) - font.lineHeight) / 4
            if #available(iOS 16.4, *) {
                baselineOffset = ((font.lineHeight * messageStyle.lineHeightMultiple) - font.lineHeight) / 2
            }
            
            bottomSheetPopupViewController.popupMessage = NSMutableAttributedString(string: message, attributes: [.font: font, .foregroundColor: UIColor.g80, .paragraphStyle: messageStyle, .baselineOffset: baselineOffset])
        }
        
        
        bottomSheetPopupViewController.insertCustomView = insertCustomView
        bottomSheetPopupViewController.cancelButtonTitle = cancelButtonTitle
        bottomSheetPopupViewController.confirmButtonTitle = confirmButtonTitle
        bottomSheetPopupViewController.closePopupOnOutsideTouch = closePopupOnOutsideTouch
        bottomSheetPopupViewController.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
        bottomSheetPopupViewController.cancelAction = cancelAction
        bottomSheetPopupViewController.confirmAction = confirmAction
        
        popupPresentingViewController.present(bottomSheetPopupViewController, animated: false)
    }
    
}

final class DealiBottomSheetPopupViewController: UIViewController {
    private let contentView = UIView()
    private var cornerLayer: CAShapeLayer?
    private let contentStackView = UIStackView()
    
    private let messageContentScrollView = UIScrollView()
    private let messageContentStackView = UIStackView()
    private let messageLabel = UILabel()
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    
    var popupTitle: NSMutableAttributedString?
    var popupMessage: NSMutableAttributedString?
    /// custom view
    var insertCustomView: UIView?
    /// 취소버튼 title
    var cancelButtonTitle: String?
    /// 확인버튼 title
    var confirmButtonTitle: String?
    /// content영역 이외의 영역 터치시 팝업을 닫을지 유무
    var closePopupOnOutsideTouch: Bool = false
    /// content영역 이외의 영역 터치로 popup을 닫을때 cancel Action 호출 유무
    var cancelActionOnOutsideTouch: Bool = false
    /// 닫기벼튼 활성화 유무
    var isCloseButtonExposure: Bool = true
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showPopup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let cornerLayer = self.cornerLayer {
            cornerLayer.removeFromSuperlayer()
        }
        
        self.cornerLayer = CAShapeLayer().then {
            $0.path = UIBezierPath(roundedRect: contentView.bounds,
                                   byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight],
                                   cornerRadii: CGSize(width: 20.0, height: 20.0)).cgPath
        }
        
        self.contentView.layer.mask = self.cornerLayer
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.do {
            $0.backgroundColor = .clear
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.backgroundColor = .primary04
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        self.contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 14.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().offset(-(12.0 + safeAreaBottomMargin))
        }
        
        if let popupTitle = self.popupTitle {
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
                $0.attributedText = popupTitle
            }.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
            
            if self.isCloseButtonExposure == true {
                let closeButton = UIButton()
                titleContainerStackView.addArrangedSubview(closeButton)
                closeButton.then {
                    $0.setImage(UIImage(named: "ic_x", in: Bundle.module, compatibleWith: nil), for: .normal)
                    $0.addTarget(self, action: #selector(closeButtonButtonAction), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
                }
            }
        }
        
        if let popupMessage = self.popupMessage {
            let messageLabel = UILabel()
            contentStackView.addArrangedSubview(messageLabel)
            messageLabel.then {
                $0.attributedText = popupMessage
                $0.numberOfLines = 0
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        if let insertCustomView = self.insertCustomView {
            contentStackView.addArrangedSubview(insertCustomView)
            insertCustomView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            if popupTitle == nil {
                contentStackView.snp.updateConstraints {
                    $0.top.equalToSuperview().offset(16.0)
                }
            }
        }
        
        if self.cancelButtonTitle != nil || self.confirmButtonTitle != nil {
            let buttonContainerView = UIView()
            contentStackView.addArrangedSubview(buttonContainerView)
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
                $0.top.bottom.equalToSuperview().inset(12.0)
                $0.left.right.equalToSuperview()
            }
            
            if let cancelButtonTitle = self.cancelButtonTitle {
                let cancelButton = DealiControl.btnOutlineLarge01()
                buttonStackView.addArrangedSubview(cancelButton)
                cancelButton.then {
                    $0.title = cancelButtonTitle
                    $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
            }
            
            if let confirmButtonTitle = self.confirmButtonTitle {
                let confirmButton = DealiControl.btnFilledLarge01()
                buttonStackView.addArrangedSubview(confirmButton)
                confirmButton.then {
                    $0.title = confirmButtonTitle
                    $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
            }
        }
        
    }
    
    func showPopup() {
        self.contentView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .b50
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    private func hidePopup(hideHandler: (() -> Void)? = nil) {
        self.contentView.snp.remakeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { [weak self] finished in
            guard let self else { return }
            self.dismiss(animated: false) {
                guard let handler = hideHandler else { return }
                handler()
            }
        }
    }
    
    @objc func closeButtonButtonAction() {
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hidePopup()
        }
    }
    
    @objc func cancelButtonAction() {
        self.hidePopup { [weak self] in
            if let self = self, let action = self.cancelAction {
                action()
            }
        }
    }
    
    @objc func confirmButtonAction() {
        self.hidePopup { [weak self] in
            if let self = self, let action = self.confirmAction {
                action()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closePopupOnOutsideTouch == true else { return }
        
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hidePopup()
        }
    }
}
