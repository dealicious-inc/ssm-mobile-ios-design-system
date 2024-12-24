//
//  DealiNotice.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 12/23/24.
//

import UIKit
import SnapKit

public final class DealiNotice: UIView {

    public func setTextLinkButton(_ textLink: TextLink) {
        self.textLinkButton = textLink
        
        self.addSubview(textLink)
        textLink.snp.makeConstraints {
            $0.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(16.0)
            $0.centerY.equalTo(self.titleLabel)
            $0.right.equalToSuperview().inset(16.0)
        }
    }
    
    public var title: String? {
        didSet {
            self.titleContentView.isHidden = title == nil
            
            guard let title else { return }
            let attributedTitle = NSMutableAttributedString(string: title)
                .font(.b2sb14)
                .color(.g100)
                .setLineHeight()
            
            self.titleLabel.attributedText = attributedTitle
        }
    }
    
    private let titleLabel = UILabel()
    private var textLinkButton: TextLink?
    private let contentView = UIView()
    
    private var titleContentView = UIView()
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addContents(_ view: UIView, layout: ((_ make: ConstraintMaker) -> Void)? = nil) {
        self.contentView.addSubview(view)
        
        if let layout {
            view.snp.makeConstraints(layout)
        } else {
            view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    public func addLabeledTextGroup(_ group: DealiLabeledTextGroupView) {
        self.addContents(group) {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    public func addLabeledTexts(_ labeledTextArray: [DealiLabeledTextView]) {
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8.0
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        }
        
        for labeledText in labeledTextArray {
            stackView.addArrangedSubview(labeledText)
        }
        
        self.addContents(stackView)
    }
}

private extension DealiNotice {
    func setUI() {
        
        self.backgroundColor = .g10
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 0.0
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
       
        self.titleContentView = self.titleView().then {
            $0.isHidden = true
        }
        
        stackView.addArrangedSubview(self.titleContentView)
        stackView.addArrangedSubview(self.contentView)
    }
    
    func titleView() -> UIView {
        let titleContentView = UIView()
        
        let iconImageView = UIImageView()
        titleContentView.addSubview(iconImageView)
        iconImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_notice")
        }.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16.0)
        }
        
        titleContentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16.0)
            $0.left.equalTo(iconImageView.snp.right).offset(8.0)
            $0.centerY.equalToSuperview()
        }
        
        let dividerView = UIView()
        titleContentView.addSubview(dividerView)
        dividerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
        }
        
        return titleContentView
    }
}
