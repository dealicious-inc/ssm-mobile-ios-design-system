//
//  DealiPlaceholderImageView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 12/23/24.
//

import UIKit
import SnapKit

public enum DealiPlaceholderImageEmptyType {
    case store
    case goods
}

public enum DealiPlaceholderImageColorType {
    case white
    case gray
}

public final class DealiPlaceholderImageView: UIImageView {

    private let emptyImageView = UIImageView()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.bounds.size.width > 0 && self.bounds.size.height > 0 else { return }
        
        print("frame = \(self.frame) / bounds = \(self.bounds)")
        let aspectRatio = self.bounds.size.width / self.bounds.size.height
        var emptyImageWidth = 0.0
        
        if abs(aspectRatio - 1.0) < 0.01 {
            /// 1:1 비율의 사이즈 일경우 empty image 사이즈 비율은 width 가 70보다 작거나 같을경우 1:2 비율, 70보다 클경우 1:2.5 비율로 정의
            if self.bounds.size.width <= 70.0 {
                emptyImageWidth = self.bounds.size.width / 2.0
            } else {
                emptyImageWidth = self.bounds.size.width / 2.5
            }
            
        } else {
            /// 3:4 비율 사이즈와 그 이외의 비율은 empty image 사이즈 비율은 1:4로 정의
            emptyImageWidth = self.bounds.size.width / 4.0
        }
        
        
        self.emptyImageView.snp.updateConstraints {
            $0.size.equalTo(CGSize(width: emptyImageWidth, height: emptyImageWidth))
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        self.addSubview(self.emptyImageView)
        self.emptyImageView.then {
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize.zero)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(emptyType: DealiPlaceholderImageEmptyType, colorType: DealiPlaceholderImageColorType) {
        guard let emptyIamge = UIImage.dealiIcon(named: (emptyType == .goods ? "ic_empty40" : "ic_home_filled"))?.withTintColor((colorType == .white ? UIColor.g20 : UIColor.primary04)) else { return }
        self.emptyImageView.image = emptyIamge
        self.backgroundColor = (colorType == .white ? .primary04 : .g20)
    }

}

public extension DealiPlaceholderImageView {
    
    func addImageMarkingView(view: UIImageView, layout: (_ make: ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints {
            layout($0)
        }
    }
}
