//
//  DealiBottomSheetBaseViewController.swift
//  
//
//  Created by 이창호 on 7/16/24.
//

import UIKit
import SnapKit

open class DealiBottomSheetBaseViewController: UIViewController {
    
    private var cornerLayer: CAShapeLayer?
    public let contentView = UIView()
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
    
    public var shouldCalulateHeightBasedOnScrollView: Bool = true
    
    private var isBottomSheetShown: Bool = false

    /// 가로 regular 폭(iPad, iPhone Duo 펼침 가로)에서 시트를 가운데 고정 폭으로 띄울 때의 최대 폭.
    /// 시스템 시트가 같은 조건에서 가운데 카드형으로 뜨는 것과 맞춘다. 세로·접힘에서는 safe area 폭을 그대로 쓴다.
    public static var wideLayoutMaxWidth: CGFloat = 650.0

    /// 마지막 레이아웃에서 고정 폭 규칙을 적용했는지. 회전·접기·펼치기로 규칙이 바뀌면 제약을 다시 잡는다.
    private var lastFixedWidthLayout: Bool?

    /// 가로 regular 폭이면 시스템 시트처럼 가운데 고정 폭으로 띄운다.
    var shouldUseFixedWidth: Bool {
        return self.traitCollection.horizontalSizeClass == .regular && self.view.bounds.width > self.view.bounds.height
    }

    /// 시트 좌우 배치 규칙. 세로·접힘에서는 시스템 시트처럼 화면 폭을 다 채운다.
    /// 상태바가 옆면에 있는 상태(iPhone Duo 닫힘)에서도 배경은 띠 밑까지 깔고, 내용은 `contentStackView`가 safe area 안에 둔다.
    /// 가로 regular 폭에서는 `wideLayoutMaxWidth`를 넘지 않는 폭으로 화면 가운데에 두되, 좌우가 safe area 밖으로 나가지는 않게 막는다.
    func makeContentViewHorizontalConstraints(_ make: ConstraintMaker) {
        if self.shouldUseFixedWidth {
            make.width.equalTo(self.view.safeAreaLayoutGuide).priority(999.0)
            make.width.lessThanOrEqualTo(Self.wideLayoutMaxWidth)
            make.centerX.equalToSuperview().priority(998.0)
            make.left.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide)
            make.right.lessThanOrEqualTo(self.view.safeAreaLayoutGuide)
        } else {
            make.left.right.equalToSuperview()
        }
    }

    /// 시트가 차지할 수 있는 최대 높이. 창 높이의 `ratio`를 넘지 않되,
    /// 상태바가 위에 있는 상태(iPhone Duo 펼침 가로)에서는 상태바 아래로 올라가지 않는다.
    public func maximumSheetHeight(ratio: CGFloat) -> CGFloat {
        let view = self.viewIfLoaded
        let windowHeight = dealiWindowSize(for: view).height
        return min(windowHeight * ratio, windowHeight - (view?.safeAreaInsets.top ?? 0.0))
    }
    
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
            $0.textColor = .g100
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
        
        if !self.isBottomSheetShown {
            // showBottomSheet 안에서 view를 다시 레이아웃하므로 재진입을 막기 위해 플래그를 먼저 올린다.
            self.isBottomSheetShown = true
            self.showBottomSheet()
        } else if self.lastFixedWidthLayout != self.shouldUseFixedWidth {
            // 회전·접기·펼치기로 폭 규칙이 바뀌면 시트 좌우 제약을 다시 잡는다.
            self.lastFixedWidthLayout = self.shouldUseFixedWidth
            self.contentView.snp.remakeConstraints {
                $0.bottom.equalToSuperview()
                self.makeContentViewHorizontalConstraints($0)
            }
        }
    }
    
    open override func loadView() {
        super.loadView()
        
        self.view.do {
            $0.backgroundColor = .clear
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.backgroundColor = .primary04
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            self.makeContentViewHorizontalConstraints($0)
        }
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.titleType == .hidden ? 16.0 : 14.0)
            // 배경(contentView)은 화면 폭을 채우고, 내용은 옆면 상태바 띠를 피해 safe area 안에 둔다.
            $0.left.right.equalTo(self.contentView.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(safeAreaBottomMargin)
        }
        
        self.contentStackView.addArrangedSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
    }
    
    func showBottomSheet() {
        // loadView 시점에는 뷰 크기가 없어 폭 규칙을 정할 수 없다.
        // 실제 크기가 잡힌 지금 좌우 제약을 먼저 확정해 두고, 올라오는 동작만 애니메이션한다.
        // 그러지 않으면 폭과 위치가 동시에 바뀌어 시트가 대각선으로 올라온다.
        self.lastFixedWidthLayout = self.shouldUseFixedWidth
        self.contentView.snp.remakeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            self.makeContentViewHorizontalConstraints($0)
        }
        self.view.layoutIfNeeded()
        
        self.contentView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            self.makeContentViewHorizontalConstraints($0)
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .b50
            self.view.layoutIfNeeded()
        }
    }
    
    open func hideBottomSheet(hideHandler: (() -> Void)? = nil) {
        self.contentView.snp.remakeConstraints {
            $0.top.equalTo(view.snp.bottom)
            self.makeContentViewHorizontalConstraints($0)
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
            $0.layoutMargins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
            $0.isLayoutMarginsRelativeArrangement = true
        }.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        titleContainerStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        titleContainerStackView.addArrangedSubview(self.closeButton)
        self.closeButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        switch self.titleType {
        case .title(let title):
            self.titleLabel.text = title
            self.closeButton.isHidden = true
        case .closeButton:
            self.closeButton.isHidden = false
        case .titleCloseButton(let title):
            self.titleLabel.text = title
            self.closeButton.isHidden = false
        default:
            break
        }
        
        return titleContainerView
    }
    
    /// containerView 에 ScrollView 타입에 View 가 addSubView 되었을때 기본적으로 높이 계산 함수
    /// 추후에 ScrollView 이외에 다른 View가 addSubView 되었을경우에는 해당 함수를 override해서 높이 계산을 재정의
    open func updateContainerViewHeight() {
        guard self.shouldCalulateHeightBasedOnScrollView else { return }
        
        for addView in self.containerView.subviews {
            if addView is UIScrollView {
                addView.layoutIfNeeded()
                var containerHeight: CGFloat = 0.0
                let bottomSheetMaxHeight = self.maximumSheetHeight(ratio: self.heightRatio)
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
