//
//  SwiftUIView.swift
//  
//
//  Created by JohyeonYoon on 2023/06/22.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

/**
 설명: UI Elements - Checkbox + Text
 */
public final class DealiCheckboxWithText: UIView {
    
    var status: CheckboxStatus {
        get {
            self.checkbox.status
        } set {
            self.checkbox.status = newValue
            self.setAppearance(for: newValue)
        }
    }
    
    public let valueChanged: PublishRelay<Bool> = .init()
    
    public var isSelected: Bool {
        get {
            return self.status.isSelected
        } set {
            self.status.isSelected = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    public var isEnabled: Bool {
        get {
            return self.status.isEnabled
        } set {
            self.status.isEnabled = newValue
            self.setAppearance(for: self.status)
        }
    }
    
    public var text: String? {
        get {
            self.titleLabel.attributedText?.string
        } set {
            guard let text = newValue else { return }
            self.titleLabel.attributedText = NSMutableAttributedString(string: text)
                .font(self.font ?? .b2r14)
                .color(.g100)
                .setLineHeight()
            
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public var attributedText: NSMutableAttributedString? {
        didSet {
            self.titleLabel.attributedText = attributedText
        }
    }
    
    @available(*, deprecated, renamed: "text")
    public var title: String? {
        get {
            self.text
        } set {
            self.text = newValue
        }
    }
    
    public var font: UIFont? {
        get {
            self.titleLabel.font
        } set {
            self.titleLabel.font = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel()
    private let checkbox = DealiCheckbox()
    
    public convenience init(text: String, status: CheckboxStatus = .init()) {
        self.init(frame: .zero)
        
        self.text = text
        self.status = status
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.checkbox)
        self.checkbox.isUserInteractionEnabled = false
        self.checkbox.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.font = .b2r14
            $0.text = self.text
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.equalTo(self.checkbox.snp.right).offset(8.0)
            $0.top.bottom.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(24.0)
        }
        
        self.setAppearance(for: self.status)
        self.subscribeRx()
    }
    
    private func subscribeRx() {
        self.rx.tapGestureOnTop()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.status.changeStatus()
                self.valueChanged.accept(self.isSelected)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setAppearance(for status: CheckboxStatus) {
        self.titleLabel.textColor = status.textColor
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
