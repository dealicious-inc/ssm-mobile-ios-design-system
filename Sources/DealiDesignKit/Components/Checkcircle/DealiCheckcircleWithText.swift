//
//  DealiCheckcircleWithText.swift
//  
//
//  Created by 윤조현 on 2024/04/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class DealiCheckcircleWithText: UIView {

    private let checkcircle = DealiCheckcircle()
    private let titleLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    public let valueChanged: PublishRelay<Bool> = .init()
    
    public var text: String {
        get {
            self.titleLabel.attributedText?.string ?? ""
        } set {
            self.titleLabel.attributedText = NSMutableAttributedString(string: newValue)
                .font(.b2r14)
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
    
    public var isSelected: Bool {
        get {
            self.checkcircle.isSelected
        } set {
            self.checkcircle.isSelected = newValue
        }
    }
    
    public var isEnabled: Bool {
        get {
            self.checkcircle.isEnabled
        } set {
            self.checkcircle.isEnabled = newValue
            self.setAppearacne()
        }
    }
    
    public var isAd: Bool {
        get {
            self.checkcircle.isAd
        } set {
            self.checkcircle.isAd = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.checkcircle)
        self.checkcircle.isUserInteractionEnabled = false
        self.checkcircle.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.text = self.text
            $0.textColor = .g100
            $0.font = UIFont.b2r14
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.equalTo(self.checkcircle.snp.right).offset(8.0)
            $0.top.bottom.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(24.0)
        }
        
        self.setAppearacne()
        
        self.rx.tapGestureOnTop()
            .when(.recognized)
            .bind(with: self) { owner, _ in
                guard owner.isEnabled else { return }
                owner.isSelected.toggle()
                owner.valueChanged.accept(owner.isSelected)
            }
            .disposed(by: self.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearacne() {
        self.titleLabel.textColor = self.isEnabled ? .g100 : .g50
    }
    
}
