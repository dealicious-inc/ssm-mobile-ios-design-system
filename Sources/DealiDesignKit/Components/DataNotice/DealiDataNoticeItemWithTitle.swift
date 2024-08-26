//
//  DealiDataNoticeItemWithTitle.swift
//
//
//  Created by 이창호 on 8/26/24.
//

import UIKit

public class DealiDataNoticeItemWithTitle: UIView {
    
    private let titlePreset: DealiDataNoticeTitlePreset
    
    private let titleLabel = UILabel()
    private var contentItemView: DealiDataNoticeItem!
    
    public var title: String = "" {
        didSet {
            self.titleLabel.attributedText = NSMutableAttributedString(string: (self.titlePreset == .regular ? "[\(self.title)]" : self.title)).font(self.titlePreset.font).color(self.titlePreset.textColor).lineHeightMultiple(1.16)
        }
    }
    
    public var contentStringArray: [String] = [] {
        didSet {
            self.contentItemView.contentStringArray = self.contentStringArray
        }
    }
    
    public init(titlePreset: DealiDataNoticeTitlePreset, itemPreset: DealiDataNoticePreset) {
        self.titlePreset = titlePreset
        
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
