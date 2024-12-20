//
//  DealiLabeledTextView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 12/19/24.
//

import UIKit

final public class DealiLabeledTextView: DealiTabBarItemBaseCell {
    
    private let preset: DealiLabeledTextPreset
    
    private let labelContainerView = UIView()
    private lazy var iconImageView = UIImageView()
    private lazy var numberingLabel = UILabel()
    private let messageLabel = UILabel()
    
    private var message: String? {
        didSet {
            guard let message = self.message else { return }
            self.attributedMessage = NSMutableAttributedString(string: message)
                .font(self.preset.font)
                .color(self.preset.textColor)
                .alignment(.left)
                .setLineHeight()
        }
    }
    
    private var attributedMessage: NSMutableAttributedString? {
        didSet {
            self.messageLabel.attributedText = self.attributedMessage
        }
    }
    
    private var numberString: String? {
        didSet {
            guard let numberString = self.numberString, self.preset.style == .number else { return }
            self.numberingLabel.attributedText = NSMutableAttributedString(string: numberString)
                .font(self.preset.font)
                .color(self.preset.textColor)
                .alignment(.left)
                .setLineHeight()
            self.numberingLabel.snp.updateConstraints {
                $0.width.equalTo(CGFloat(numberString.size(withAttributes: [.font: self.preset.font]).width))
            }
        }
    }
    
    private var iconName: String? {
        didSet {
            guard let iconName = self.iconName, self.preset.style == .icon else { return }
            self.iconImageView.image = UIImage.dealiIcon(named: iconName)?.withTintColor(self.preset.textColor).resize(CGSize(width: 16.0, height: 16.0))
        }
    }
    
    private var customView: UIView? {
        didSet {
            guard let customView = self.customView else { return }
            self.labelContainerView.addSubview(customView)
            customView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
            }
        }
    }
    
    public init(preset: DealiLabeledTextPreset) {
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.addSubview(self.labelContainerView)
        self.labelContainerView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        self.addSubview(self.messageLabel)
        self.messageLabel.then {
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(labelContainerView.snp.right).offset(self.preset.itemSpacing)
        }
        
        switch self.preset.style {
        case .bullet:
            let bulletImageView = UIImageView()
            self.labelContainerView.addSubview(bulletImageView)
            bulletImageView.then {
                $0.layer.cornerRadius = 1.5
                $0.layer.masksToBounds = true
                $0.backgroundColor = self.preset.textColor
            }.snp.makeConstraints {
                $0.top.equalToSuperview().inset(7.5)
                $0.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
            }
        case .number:
            self.labelContainerView.addSubview(self.numberingLabel)
            self.numberingLabel.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.width.equalTo(0.0)
            }
        case .icon:
            self.labelContainerView.addSubview(self.iconImageView)
            self.iconImageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(1.0)
                $0.left.right.equalToSuperview()
                $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
            }
        default:
            break
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(model: DealiLabeledTextModel?) {
        guard let model = model else { return }
        
        if let message = model.message {
            self.message = message
        } else if let attributedMessage = model.attributedMessage {
            self.attributedMessage = attributedMessage
        }
        
        self.iconName = model.iconName
        self.numberString = model.numberString
    }
    
}
