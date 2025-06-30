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
    
    open override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.backgroundColor = .primary04
            $0.setCornerRadius(10.0)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40.0)
            $0.centerY.equalToSuperview()
        }
        
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
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
