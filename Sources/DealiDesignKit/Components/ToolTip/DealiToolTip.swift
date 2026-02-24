//
//  DealiToolTip.swift
//  DealiDesignKit
//
//  Created by Nam Jun Lee on 12/31/24.
//

import UIKit
import SnapKit
import RxSwift

public enum DealiToopTipArrowPosition: String, CaseIterable {
    case topLeft
    case topCenter
    case topRight
    case bottomLeft
    case bottomCenter
    case bottomRight
}

public class DealiToolTip: UIView {
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let containerView = UIView()
    private let disposeBag = DisposeBag()
    
    private var autoDismissWorkItem: DispatchWorkItem?
    
    private var dismissAction: (() -> Void)?
    
    public enum EToolTipColor {
        case blue
        case white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.alpha = 0.0
    }
    
    private func setToolTipLayout(arrowPosition: DealiToopTipArrowPosition) {
        self.addSubview(self.arrowImageView)
        self.arrowImageView.then {
            $0.image = .dealiIcon(named: "img_tailanchor")
        }.snp.makeConstraints {
            $0.width.equalTo(12.0)
            $0.height.equalTo(6.0)
            
            switch arrowPosition {
            case .topLeft:
                $0.top.equalToSuperview()
                $0.left.equalToSuperview().inset(21.0)
                self.arrowImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
            case .topCenter:
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                self.arrowImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
            case .topRight:
                $0.top.equalToSuperview()
                $0.right.equalToSuperview().inset(21.0)
                self.arrowImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
            case .bottomLeft:
                $0.bottom.equalToSuperview()
                $0.left.equalToSuperview().inset(21.0)
            case .bottomCenter:
                $0.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
            case .bottomRight:
                $0.bottom.equalToSuperview()
                $0.right.equalToSuperview().inset(21.0)
            }
        }
        
        self.addSubview(self.containerView)
        self.containerView.then {
            $0.backgroundColor = .secondary01
            $0.layer.cornerRadius = 6.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            switch arrowPosition {
            case .topLeft, .topCenter, .topRight:
                $0.top.equalTo(self.arrowImageView.snp.bottom)
                $0.bottom.equalToSuperview()
            case .bottomLeft, .bottomCenter, .bottomRight:
                $0.top.equalToSuperview()
                $0.bottom.equalTo(self.arrowImageView.snp.top)
            }
        }
        
        containerView.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.font = .b3sb13
            $0.textColor = .primary04
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    private func setColor(_ color: EToolTipColor) {
        switch color {
        case .blue:
            self.titleLabel.textColor = .primary04
            self.containerView.backgroundColor = .secondary01
            self.arrowImageView.image = .dealiIcon(named: "img_tailanchor")?.withTintColor(.secondary01)
        case .white:
            self.titleLabel.textColor = .g100
            self.containerView.backgroundColor = .primary04
            self.arrowImageView.image = .dealiIcon(named: "img_tailanchor")?.withTintColor(.primary04)

        }
    }
    
    func cancelAutoDismiss() {
        self.autoDismissWorkItem?.cancel()
        self.autoDismissWorkItem = nil
    }
    
    func scheduleAutoDismiss(after seconds: TimeInterval, cleanup: @escaping () -> Void) {
        self.cancelAutoDismiss()
        let work = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.dismissToolTip {
                cleanup()
            }
        }
        self.autoDismissWorkItem = work
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: work)
    }
    
    /// 툴팁 노출
    ///
    ///  - Parameters:
    ///   - arrowPosition: 화살표 위치
    ///   - color: backgrond 컬러. default: blue
    ///   - text: 툴팁에 표시할 텍스트
    ///   - superView: 툴팁을 추가할 뷰
    ///   - outsideView: 툴팁 제외한 영역을 클릭했을 때 툴팁을 닫을 뷰
    ///   - dismissToolTipOnOutsideViewTouch : outsideView를 터치했을때 ToolTip Dismiss액션 유무
    ///   - dismissToolTipOnToolTipViewTouch : ToolTip를 터치했을때 ToolTip Dismiss액션 유무
    ///   - autoDismissAfter : 일정시간 후에 tooltip Dismiss액션 실행이 필요한경우
    ///   - toolTipCondition: 툴팁을 노출할 조건
    ///   - toolTipLayout: 툴팁 레이아웃
    ///   - toolTipAction: 툴팁 클릭 액션 (optional) - 툴팁이 사라지면서 실행
    ///  - Returns: 툴팁 객체
    @discardableResult
    public static func show(
        arrowPosition: DealiToopTipArrowPosition,
        color: EToolTipColor = .blue,
        text: String,
        superView: UIView,
        outsideView: UIView,
        dismissToolTipOnOutsideViewTouch: Bool = true,
        dismissToolTipOnToolTipViewTouch: Bool = true,
        autoDismissAfter: TimeInterval? = nil,
        toolTipCondition: () -> Bool,
        toolTipLayout: (ConstraintMaker) -> Void,
        toolTipAction: (() -> Void)? = nil,
        dismissAction: (() -> Void)? = nil
    ) -> DealiToolTip? {
        guard toolTipCondition() else { return nil }
        
        let toolTip = DealiToolTip()
        toolTip.setToolTipLayout(arrowPosition: arrowPosition)
        toolTip.titleLabel.attributedText = NSMutableAttributedString(string: text).font(.b3sb13).setLineHeight()
        toolTip.setColor(color)
        superView.addSubview(toolTip)
        toolTip.snp.makeConstraints {
            toolTipLayout($0)
        }
        
        let dismissView = UIView()
        outsideView.addSubview(dismissView)
        dismissView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        superView.bringSubviewToFront(toolTip)
        
        toolTip.dismissAction = dismissAction
        
        dismissView.rx.touchDownGesture()
            .when(.recognized)
            .bind { [weak toolTip, weak dismissView] _ in
                guard dismissToolTipOnOutsideViewTouch == true else { return }
                toolTip?.cancelAutoDismiss()
                toolTip?.dismissToolTip {
                    toolTip?.removeFromSuperview()
                }
                
                dismissView?.removeFromSuperview()
            }
            .disposed(by: toolTip.disposeBag)
        toolTip.rx.tapGestureOnTop()
            .when(.recognized)
            .bind { [weak toolTip, weak dismissView] _ in
                guard dismissToolTipOnToolTipViewTouch == true else { return }
                toolTip?.cancelAutoDismiss()
                toolTip?.dismissToolTip {
                    toolTip?.removeFromSuperview()
                }
                toolTipAction?()
                dismissView?.removeFromSuperview()
            }
            .disposed(by: toolTip.disposeBag)
        
        if let delay = autoDismissAfter {
            toolTip.scheduleAutoDismiss(after: delay) { [weak toolTip, weak dismissView] in
                toolTip?.dismissToolTip {
                    toolTip?.removeFromSuperview()
                }
                
                dismissView?.removeFromSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: { [weak toolTip] in
            guard let toolTip else {return}
            toolTip.alpha = 1.0
        })
        
        return toolTip
    }
    
    private func dismissToolTip(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            guard let self else {return}
            self.alpha = 0.0
        }) { [weak self] _ in
            self?.dismissAction?()
            completion?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
