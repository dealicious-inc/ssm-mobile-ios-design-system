//
//  DealiDataNoticeItemWithTitle.swift
//
//
//  Created by 이창호 on 8/26/24.
//

import UIKit

public class DealiDataNoticeItemWithTitle: UIView {
    
    private let titleLabel = UILabel()
    private var contentItemView: DealiDataNoticeItem!
    
    public var title: String = "" {
        didSet {
            self.titleLabel.attributedText = NSMutableAttributedString(string: self.title)
                .font(.b3sb13)
                .color(DealiColor.g100)
                .alignment(.left)
                .setLineHeight()
        }
    }
    
    public var contentStringArray: [String] = [] {
        didSet {
            self.contentItemView.contentStringArray = self.contentStringArray
        }
    }
    
    public init(itemPreset: DealiDataNoticePreset) {
        super.init(frame: .zero)

        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        self.contentItemView = DealiDataNoticeItem(preset: itemPreset)
        self.addSubview(self.contentItemView)
        self.contentItemView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
