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
            self.titleLabel.text ?? ""
        } set {
            self.titleLabel.text = newValue
            self.invalidateIntrinsicContentSize()
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
    
    public override var intrinsicContentSize: CGSize {
        self.titleLabel.sizeToFit()
        
        let width = self.titleLabel.frame.width + 24.0 + 8.0
        let height = self.titleLabel.frame.height
        return CGSize(width: width, height: max(24.0, height))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.checkcircle)
        self.checkcircle.isUserInteractionEnabled = false
        self.checkcircle.snp.makeConstraints {
            $0.top.bottom.left.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.textAlignment = .left
            $0.text = self.text
            $0.textColor = .g100
            $0.font = UIFont.b2r14
        }.snp.makeConstraints {
            $0.left.equalTo(self.checkcircle.snp.right).offset(8.0)
            $0.centerY.right.equalToSuperview()
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DealiCheckcircleWithTextPreview: PreviewProvider {
    static var previews: some View {
    
        VStack {
            UIViewPreview {
                let checkCircle = DealiCheckcircleWithText()
                checkCircle.text = "Text"
                return checkCircle
            }
            
            UIViewPreview {
                let checkCircle = DealiCheckcircleWithText()
                checkCircle.isSelected = true
                checkCircle.isAd = false
                
                checkCircle.text = "Text"

                return checkCircle
            }
            
            UIViewPreview {
                let checkCircle = DealiCheckcircleWithText()
                checkCircle.isAd = true
                checkCircle.isSelected = true
                checkCircle.text = "Text"

                return checkCircle
            }
            
            // 프리뷰에는 반영이 안된다
            UIViewPreview {
                let checkCircle = DealiCheckcircleWithText()
                checkCircle.isEnabled = false
                checkCircle.text = "Text"

                return checkCircle
            }
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .previewDisplayName("DealiCheckcircleWithText")
    }
}
#endif


