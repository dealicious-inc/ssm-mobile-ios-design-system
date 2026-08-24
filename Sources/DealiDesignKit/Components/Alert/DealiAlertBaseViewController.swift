//
//  DealiAlertBaseViewController.swift
//  DealiDesignKit
//
//  Created by 이창호 on 6/25/25.
//

import UIKit

open class DealiAlertBaseViewController: UIViewController {

    public let contentView = UIView()
    public let contentStackView = UIStackView()
    
    /// alert content 영역의 최대 너비
    public static let maxContentWidth: CGFloat = 360.0
    /// alert content 영역의 좌우 최소 여백
    public static let contentHorizontalPadding: CGFloat = 40.0
    
    /// alert 최대 높이 값이 동적으로 정해질때의 최대 높이값을 정하는 비율값
    public var heightRatio: CGFloat = 0.7
    /// alert 최대 높이값이 정적으로 지정되야 할경우 세팅되는 높이값
    public var fixedHeight: CGFloat = 0.0
    /// alert에서 최대 높이값을 계산해서 처리해야 할때 고정되어 사용해야하는 객체들의 높이의 합
    public var totalFixedContentHeight: CGFloat = 0.0
    
    /// content이외 영영 터치로 alert을 닫을지 유무
    public var closeAlertOnOutsideTouch: Bool = false
    /// content이외 영영 터치로 alert을 닫을때 cancel action을 호출할지 유무
    public var cancelActionOnOutsideTouch: Bool = false
    
    public var shouldCalulateHeightBasedOnScrollView: Bool = true

    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updateContainerViewHeight()
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .b40
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShowNotification(_ notification: NSNotification) {

        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardVisibleHeight = keyboardFrame.cgRectValue.height
        
        self.remakeContentViewConstraints(keyboardVisibleHeight: keyboardVisibleHeight)
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardHideNotification(_ notification: NSNotification) {

        guard let _ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        self.remakeContentViewConstraints()
        self.view.layoutIfNeeded()
    }
    
    /// contentView는 기본적으로 좌우 여백 기준으로 너비가 늘어나고, `maxContentWidth`를 넘으면 그 값으로 고정된다
    private func remakeContentViewConstraints(keyboardVisibleHeight: CGFloat = 0.0) {
        self.contentView.snp.remakeConstraints {
            $0.width.equalToSuperview().offset(-(Self.contentHorizontalPadding * 2.0)).priority(999.0)
            $0.width.lessThanOrEqualTo(Self.maxContentWidth)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-keyboardVisibleHeight / 2.0)
        }
    }
    
    open override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.contentView)
        self.contentView.do {
            $0.backgroundColor = .primary04
            $0.setCornerRadius(10.0)
        }
        self.remakeContentViewConstraints()
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 0.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24.0)
            $0.left.right.bottom.equalToSuperview().inset(20.0)
        }
    }
    
    open func hideAlert(hideHandler: (() -> Void)? = nil) {
        self.dismiss(animated: true) {
            guard let handler = hideHandler else { return }
            handler()
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closeAlertOnOutsideTouch == true else { return }
        
        self.hideAlert()
    }
    
    /// containerView 에 ScrollView 타입에 View 가 addSubView 되었을때 기본적으로 높이 계산 함수
    /// 추후에 ScrollView 이외에 다른 View가 addSubView 되었을경우에는 해당 함수를 override해서 높이 계산을 재정의
    open func updateContainerViewHeight() {
        guard self.shouldCalulateHeightBasedOnScrollView else { return }
        
        let alertMaxHeight = (UIScreen.main.bounds.size.height * self.heightRatio) - (24.0 + 20.0)
        
        for addView in self.contentStackView.arrangedSubviews {
            if addView is UIScrollView {
                addView.layoutIfNeeded()
                var containerHeight: CGFloat = 0.0
                
                if self.fixedHeight > 0.0 {
                    containerHeight = (self.fixedHeight - self.totalFixedContentHeight)
                } else {
                    containerHeight = (addView as! UIScrollView).contentSize.height
                    
                    if (containerHeight + self.totalFixedContentHeight) > alertMaxHeight {
                        containerHeight = (alertMaxHeight - self.totalFixedContentHeight)
                    }
                }
                
                addView.snp.remakeConstraints {
                    $0.left.right.equalToSuperview()
                    $0.height.equalTo(containerHeight)
                }
                
                break
            }
        }
    }

}
