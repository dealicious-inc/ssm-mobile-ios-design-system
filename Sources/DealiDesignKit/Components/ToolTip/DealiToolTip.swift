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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    private func setToolTipLayout(arrowPosition: DealiToopTipArrowPosition) {
        self.addSubview(self.arrowImageView)
        self.arrowImageView.then {
            $0.image = .dealiIcon(named: "tail")
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
            $0.backgroundColor = UIColor(rgb: 0x3668F4)
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
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    @discardableResult
    public static func show(
        arrowPosition: DealiToopTipArrowPosition,
        text: String,
        superView: UIView,
        outsideView: UIView,
        toolTipCondition: () -> Bool,
        toolTipLayout: (ConstraintMaker) -> Void
    ) -> DealiToolTip? {
        guard toolTipCondition() else { return nil }
        
        let toolTip = DealiToolTip()
        toolTip.setToolTipLayout(arrowPosition: arrowPosition)
        toolTip.titleLabel.text = text
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
        dismissView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak toolTip, weak dismissView] _ in
                toolTip?.removeFromSuperview()
                dismissView?.removeFromSuperview()
            }
            .disposed(by: toolTip.disposeBag)
        toolTip.rx.tapGestureOnTop()
            .when(.recognized)
            .bind { [weak toolTip, weak dismissView] _ in
                toolTip?.removeFromSuperview()
                dismissView?.removeFromSuperview()
            }
            .disposed(by: toolTip.disposeBag)
        
        return toolTip
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
