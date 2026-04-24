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
    
    private var titleString: String = ""
    private var baseAttributedText: NSMutableAttributedString?
    
    public let valueChanged: PublishRelay<Bool> = .init()
    
    public var text: String {
        get {
            return self.titleString
        } set {
            self.titleString = newValue
            self.baseAttributedText = nil
            self.updateTitleAppearance()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public var attributedText: NSMutableAttributedString? {
        didSet {
            self.baseAttributedText = attributedText
            self.updateTitleAppearance()
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
            self.updateTitleAppearance()
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
            $0.textColor = .g100
            $0.font = UIFont.b2r14
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.left.equalTo(self.checkcircle.snp.right).offset(8.0)
            $0.top.bottom.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(24.0)
        }
        
        self.updateTitleAppearance()
        
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
    
    private func updateTitleAppearance() {
        let textColor: UIColor = self.isEnabled ? .g100 : .g50
        
        if let baseAttributedText = self.baseAttributedText?.mutableCopy() as? NSMutableAttributedString {
            let fullRange = NSRange(location: 0, length: baseAttributedText.length)
            baseAttributedText.addAttribute(.foregroundColor, value: textColor, range: fullRange)
            self.titleLabel.attributedText = baseAttributedText
        } else {
            self.titleLabel.attributedText = NSMutableAttributedString(string: self.titleString)
                .font(.b2r14)
                .color(textColor)
                .setLineHeight()
        }
    }
}
