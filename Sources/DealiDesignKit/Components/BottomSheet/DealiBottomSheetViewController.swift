//
//  DealiBottomSheetViewController.swift
//
//
//  Created by JohyeonYoon on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa

/**
 설명: <#설명#>
 */
open class DealiBottomSheetViewController: UIViewController {
    
    /// 우상단 닫기 버튼. default 는 미노출.
    public let closeButton = UIButton()
    /// 백그라운드 터치시 바텀시트 닫을지 여부. default는 허용.
    public var canDismissByBackgroundTouch: Bool = true
    /// 바텀시트 타이틀 라벨.
    public let titleLabel = UILabel()
    
    let sheetView = UIView()
    /// 타이틀 제외하고 컨텐츠가 들어가는 뷰
    public let contentview = UIView()
    
    public var cancelhandler: (() -> Void)?
    
    public let disposeBag = DisposeBag()
    
    private var cornerLayer: CAShapeLayer?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .clear
        
        self.view.addSubview(self.sheetView)
        self.sheetView.then {
            $0.clipsToBounds = true
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.sheetView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .sh2sb18
            $0.textColor = DealiColor.g100
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.0)
            $0.left.equalToSuperview().inset(16.0)
            $0.height.equalTo(26.0)
        }
        
        self.sheetView.addSubview(self.closeButton)
        self.closeButton.then {
            $0.setImage(UIImage(named: "ic_x", in: Bundle.module, compatibleWith: nil), for: .normal)
            $0.isHidden = true
            $0.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
            $0.top.equalToSuperview().inset(25.0)
            $0.right.equalToSuperview().inset(16.0)
        }
        
        self.sheetView.addSubview(self.contentview)
        self.contentview.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let cornerLayer {
            cornerLayer.removeFromSuperlayer()
        }
        
        self.cornerLayer = CAShapeLayer().then {
            $0.path = UIBezierPath(
                roundedRect: self.sheetView.bounds,
                byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight],
                cornerRadii: CGSize(width: 16.0, height: 16.0)
            ).cgPath
        }
        
        self.sheetView.layer.mask = self.cornerLayer

        if self.sheetView.tag == 0 {
            self.sheetView.tag = 100
            self.showBottomSheet()
        }
    }
    
    @objc func closeButtonPressed() {
        self.dismissBottomSheet()
    }

    public func showBottomSheet() {
        self.view.layoutIfNeeded()
        self.view.backgroundColor = DealiColor.b50
    
        self.sheetView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self else { return }
            self.view.layoutIfNeeded()
        })
    }
    
    public func dismissBottomSheet(completionHandler: (() -> Void)? = nil) {
        self.sheetView.snp.remakeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            guard let self else { return }
            
            if self.isModal {
                self.dismiss(animated: true) {
                    completionHandler?()
                }
            } else {
                self.view.removeFromSuperview()
                self.removeFromParent()
                completionHandler?()
            }
        })
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard self.canDismissByBackgroundTouch, let touch = touches.first else { return }
        
        // 빈 여백만 클릭시 닫기처리
        let location = touch.location(in: self.view)
        if self.sheetView.frame.contains(location) == false {
            self.dismissBottomSheet(completionHandler: self.cancelhandler)
        }
    }
}
