//
//  DealiBottomSheetBaseViewController.swift
//  
//
//  Created by 이창호 on 7/16/24.
//

import UIKit

open class DealiBottomSheetBaseViewController: UIViewController {
    
    private var cornerLayer: CAShapeLayer?
    private let contentView = UIView()
    public let contentStackView = UIStackView()
    public let containerView = UIView()
    
    public let titleContentViewHeight = 46.0
    /// bottomSheet 최대 높이 값이 동적으로 정해질때의 최대 높이값을 정하는 비율값
    public var heightRatio: CGFloat = 0.9
    /// bottomSheet 최대 높이값이 정적으로 지정되야 할경우 세팅되는 높이값
    public var fixedHeight: CGFloat = 0.0
    
    /// content영역 이외의 영역 터치시 팝업을 닫을지 유무
    public var closeBottomSheetOnOutsideTouch: Bool = false
    /// close버튼 클릭시 호출되는 ActionHandler
    public var closeActionHandler: (() -> Void)?
    
    /// 타이들 영역 노출 타입
    public var titleType: EBottomSheetTitleType = .hidden {
        didSet {
            if self.titleType != .hidden {
                let titleContainerView = self.titleContainerView()
                
                self.contentStackView.insertArrangedSubview(titleContainerView, at: 0)
                titleContainerView.snp.makeConstraints {
                    $0.left.right.equalToSuperview()
                    $0.height.equalTo(titleContentViewHeight)
                }
            }
        }
    }
    
    public var titleString: String? {
        didSet {
            if let titleString = self.titleString {
                self.titleLabel.text = titleString
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.numberOfLines = 0
            $0.font = .sh2sb18
            $0.textColor = DealiColor.g100
        }
    }()
    
    private lazy var closeButton: UIButton = {
        return UIButton().then {
            $0.setImage(UIImage(named: "ic_x", in: Bundle.module, compatibleWith: nil), for: .normal)
            $0.addTarget(self, action: #selector(closeButtonButtonAction), for: .touchUpInside)
        }
    }()

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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet()
    }
    
    public override func viewDidLayoutSubviews() {
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
        
        self.updateContainerViewHeight()
        
    }
    
    open override func loadView() {
        super.loadView()
        
        self.view.do {
            $0.backgroundColor = .clear
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.titleType == .hidden ? 16.0 : 14.0)
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(safeAreaBottomMargin)
        }
        
        self.contentStackView.addArrangedSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
    }
    
    func showBottomSheet() {
        self.contentView.layoutIfNeeded()
        
        self.contentView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = DealiColor.b50
            self.view.layoutIfNeeded()
        }
    }
    
    open func hideBottomSheet(hideHandler: (() -> Void)? = nil) {
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
        self.hideBottomSheet { [weak self] in
            if let self = self, let handler = self.closeActionHandler {
                handler()
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closeBottomSheetOnOutsideTouch == true else { return }
        
        self.hideBottomSheet { [weak self] in
            if let self = self, let handler = self.closeActionHandler {
                handler()
            }
        }
    }
    
    // MARK: Setting UI
    private func titleContainerView() -> UIView {
        let titleContainerView = UIView()
        
        let titleContainerStackView = UIStackView()
        titleContainerView.addSubview(titleContainerStackView)
        titleContainerStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 16.0
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        switch self.titleType {
        case .title(let title):
            titleContainerStackView.addArrangedSubview(self.titleLabel)
            self.titleLabel.text = title
            self.titleLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        case .closeButton:
            titleContainerStackView.addArrangedSubview(self.closeButton)
            self.closeButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
        case .titleCloseButton(let title):
            titleContainerStackView.addArrangedSubview(self.titleLabel)
            self.titleLabel.text = title
            self.titleLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
            
            titleContainerStackView.addArrangedSubview(self.closeButton)
            self.closeButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            }
        default:
            break
        }
        
        return titleContainerView
    }
    
    /// containerView 에 ScrollView 타입에 View 가 addSubView 되었을때 기본적으로 높이 계산 함수
    /// 추후에 ScrollView 이외에 다른 View가 addSubView 되었을경우에는 해당 함수를 override해서 높이 계산을 재정의
    open func updateContainerViewHeight() {
        for addView in self.containerView.subviews {
            if addView is UIScrollView {
                addView.layoutIfNeeded()
                var containerHeight: CGFloat = 0.0
                let bottomSheetMaxHeight = (UIScreen.main.bounds.size.height * self.heightRatio)
                let titleContentHeight = (self.titleType == .hidden ? 0.0 : self.titleContentViewHeight)
                
                if self.fixedHeight > 0.0 {
                    containerHeight = self.fixedHeight - titleContentHeight
                } else {
                    containerHeight = (addView as! UIScrollView).contentSize.height
                    
                    if (containerHeight + titleContentHeight + safeAreaBottomMargin ) > bottomSheetMaxHeight {
                        containerHeight = bottomSheetMaxHeight - (titleContentHeight + safeAreaBottomMargin)
                    }
                }
                
                self.containerView.snp.remakeConstraints {
                    $0.left.right.equalToSuperview()
                    $0.height.equalTo(containerHeight)
                }
                
                break
            }
        }
    }

}
