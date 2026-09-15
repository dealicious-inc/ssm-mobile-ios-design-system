//
//  DealiLabeledTextView.swift
//  DealiDesignKit
//
//  Created by Lee Chang Ho on 12/19/24.
//

import UIKit

final public class DealiLabeledTextView: UIView {
    
    private let preset: DealiLabeledTextPreset
    
    private let labeledStackView = UIStackView()
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
    
    private var number: Int? {
        didSet {
            guard let number = self.number, self.preset.style == .number else { return }
            let numberString = "\(number)."
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
    
    /// 문구영역의 링크 텍스트를 탭했을때 호출되는 핸들러. 설정되어 있을때만 messageLabel에 탭 제스처가 연결된다
    private var textLinkHandler: ((String) -> Void)?
    private var messageLinkTapGesture: UITapGestureRecognizer?
    
    private var labeledCustomView: UIView? {
        didSet {
            guard let labeledCustomView = self.labeledCustomView else { return }
            self.labeledStackView.addArrangedSubview(labeledCustomView)
        }
    }
    
    public init(preset: DealiLabeledTextPreset) {
        self.preset = preset
        
        super.init(frame: .zero)
        
        self.addSubview(self.labeledStackView)
        self.labeledStackView.then {
            $0.axis = .horizontal
            $0.spacing = preset.itemSpacing
            $0.alignment = .center
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(18.0)
        }
        
        self.addSubview(self.messageLabel)
        self.messageLabel.then {
            $0.numberOfLines = 0
        }.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(labeledStackView.snp.right).offset(self.preset.itemSpacing)
        }
        
        switch self.preset.style {
        case .bullet:
            let bulletImageView = UIImageView()
            self.labeledStackView.addArrangedSubview(bulletImageView)
            bulletImageView.then {
                $0.layer.cornerRadius = 1.5
                $0.layer.masksToBounds = true
                $0.backgroundColor = self.preset.textColor
            }.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
            }
        case .number:
            self.labeledStackView.addArrangedSubview(self.numberingLabel)
            self.numberingLabel.snp.makeConstraints {
                $0.width.equalTo(0.0)
            }
        case .icon:
            self.labeledStackView.addArrangedSubview(self.iconImageView)
            self.iconImageView.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 16.0, height: 16.0))
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
        self.number = model.number
        self.labeledCustomView = model.labeledCustomView
        self.textLinkHandler = model.textLinkHandler
        
        self.updateMessageLinkTapGesture()
    }
    
    /// textLinkHandler 유무에 따라 messageLabel의 탭 제스처를 연결하거나 해제한다. configure를 다시 호출해도 제스처가 중복 등록되지 않는다
    private func updateMessageLinkTapGesture() {
        if self.textLinkHandler != nil {
            guard self.messageLinkTapGesture == nil else { return }
            
            let messageLinkTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.messageLabelDidTap(_:)))
            self.messageLabel.isUserInteractionEnabled = true
            self.messageLabel.addGestureRecognizer(messageLinkTapGesture)
            self.messageLinkTapGesture = messageLinkTapGesture
        } else {
            guard let messageLinkTapGesture = self.messageLinkTapGesture else { return }
            
            self.messageLabel.removeGestureRecognizer(messageLinkTapGesture)
            self.messageLabel.isUserInteractionEnabled = false
            self.messageLinkTapGesture = nil
        }
    }
    
    @objc private func messageLabelDidTap(_ gesture: UITapGestureRecognizer) {
        guard let linkText = self.messageLabel.tappedLinkText(at: gesture.location(in: self.messageLabel)) else { return }
        
        self.textLinkHandler?(linkText)
    }
    
    public convenience init(preset: DealiLabeledTextPreset, model: DealiLabeledTextModel) {
        self.init(preset: preset)
        self.configure(model: model)
    }
}
