//
//  Created by yunjohyeon on 2023/04/26.
//  Copyright © 2015 Dealicious Inc. All rights reserved.
//

import UIKit
import Then
import SnapKit

public final class SmallPrimaryFulledGrayTag: UIView {
    
    private let contentLabel = UILabel()
    
    public var text: String = "" {
        didSet {
            self.contentLabel.dealiText = text
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        self.contentLabel.sizeToFit()
        let width = self.contentLabel.frame.width + 8.0
        return CGSize(width: width, height: 18.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = DealiColor.g10
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
        
        self.addSubview(self.contentLabel)
        self.contentLabel.then {
            $0.textColor = DealiColor.g70
            $0.font = .systemFont(ofSize: 10.0, weight: .bold)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(4.0)
            $0.top.bottom.equalToSuperview().inset(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
