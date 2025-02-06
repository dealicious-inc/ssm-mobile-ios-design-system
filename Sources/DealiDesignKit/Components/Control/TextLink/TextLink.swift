//
//  TextLink.swift
//  DealiDesignKit
//
//  Created by 윤조현 on 12/6/24.
//

import UIKit

final public class TextLink: SystemButton {
    
    public var contentInsets: NSDirectionalEdgeInsets = .zero {
        didSet {
            self.setButtonConfiguarion()
        }
    }
    
    public var title: String? {
        didSet {
            self.updateUI(for: self.status)
        }
    }
    
    public var leftImage: ClickableImage? {
        didSet {
            self.leftIconImageView.image = self.leftImage?.uiImage?.withTintColor(self.systemConfig.iconColor)
            self.leftIconImageView.isHidden = (self.leftImage == nil)
        }
    }
    
    public var rightImage: ClickableImage? {
        didSet {
            self.rightIconImageView.image = self.rightImage?.uiImage?.withTintColor(self.systemConfig.iconColor)
            self.rightIconImageView.isHidden = (self.rightImage == nil)
        }
    }

    enum Constants {
        static let contentSpacing: CGFloat = 4.0
        static let iconImageSize: CGSize = CGSize(width: 16.0, height: 16.0)
    }
    
    private var systemConfig = TextLinkConfig(size: TextLinkSizeType.large.size, style: TextLinkStyleType.primary01.style)
    
    init(systemConfig: TextLinkConfig) {
        self.systemConfig = systemConfig
        
        super.init(frame: .zero)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentStackView = UIStackView()
    private let leftIconImageView = UIImageView()
    private let textLabel = UILabel()
    private let rightIconImageView = UIImageView()
    
    private func setButtonConfiguarion() {
        var configuration = Configuration.plain()
        configuration.contentInsets = self.contentInsets
        self.configuration = configuration
        
        self.contentStackView.layoutMargins = self.contentInsets.toUIEdgeInsets()
    }
    
    override func setUI() {
        super.setUI()
        
        self.setButtonConfiguarion()
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = Constants.contentSpacing
            $0.isUserInteractionEnabled = false
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = self.contentInsets.toUIEdgeInsets()
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.leftIconImageView)
        self.leftIconImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(Constants.iconImageSize)
        }
        
        self.contentStackView.addArrangedSubview(self.textLabel)
        self.textLabel.do {
            $0.textAlignment = .left
        }
        
        self.contentStackView.addArrangedSubview(self.rightIconImageView)
        self.rightIconImageView.then {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFill
        }.snp.makeConstraints {
            $0.size.equalTo(Constants.iconImageSize)

        }
    }
    
    override func updateUI(for state: DealiButtonStatus) {
        self.systemConfig.status = state
        self.updateContent()
    }
    
    private func updateContent() {
        self.textLabel.textColor = self.systemConfig.textColor
        self.textLabel.font = self.systemConfig.textFont
        
        self.textLabel.attributedText = NSMutableAttributedString(string: self.title ?? "")
            .underline(if: (self.systemConfig.withLine && self.status != .disabled), color: self.systemConfig.textColor)
            .setLineHeight()
        
        if self.leftImage != nil {
            self.leftIconImageView.image = self.leftImage?.uiImage?.withTintColor(self.systemConfig.iconColor)
        }
        
        if self.rightImage != nil {
            self.rightIconImageView.image = self.rightImage?.uiImage?.withTintColor(self.systemConfig.iconColor)
        }
    }
}
