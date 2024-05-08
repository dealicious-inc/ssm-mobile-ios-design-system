//
//  DealiEmptyView.swift
//  
//
//  Created by 이창호 on 5/8/24.
//

import UIKit

public enum DealiEmptyImageType {
    case info  // info image
    case refresh // refresh image
    case noImage // 이미지 없음
}

public final class DealiEmptyView: UIView {
    private let contentStackView = UIStackView()
    private let emptyImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = DealiControl.btnFilledLarge01()
    
    /// 기본적으로 empty가 노출 되는 화면에서 상단에서 72.0 만큼 떨어진 영역에서부터 empty가 노출되도록 처리, 이후 해당 값을 조정해서 노출 위치 수정
    public var topMargin: CGFloat = 72.0 {
        willSet {
            if self.topMargin != newValue {
                self.contentStackView.snp.updateConstraints {
                    $0.top.equalToSuperview().offset(newValue)
                }
            }
        }
    }
    
    private var actionHandler: (() -> Void)?
    
    public init() {
        super.init(frame: .zero)
        
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 12.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topMargin)
            $0.left.right.equalToSuperview().inset(24.0)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.emptyImageView)
        self.emptyImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 32.0, height: 32.0))
            $0.centerX.equalToSuperview()
        }
        
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.numberOfLines = 0
            $0.font = .sh3sb16
            $0.textColor = DealiColor.g100
            $0.textAlignment = .center
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.contentStackView.setCustomSpacing(8.0, after: self.titleLabel)
        self.contentStackView.addArrangedSubview(self.messageLabel)
        self.messageLabel.then {
            $0.numberOfLines = 0
            $0.font = .b2r14
            $0.textColor = DealiColor.g60
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        self.contentStackView.setCustomSpacing(24.0, after: self.messageLabel)
        self.contentStackView.addArrangedSubview(self.actionButton)
        self.actionButton.then {
            $0.title = "재시도"
        }.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setEmpty(imageType: DealiEmptyImageType = .noImage, title: String? = nil, message: String, actionButtonTitle: String? = nil, actionHandler: (() -> Void)? = nil) {
        
        self.emptyImageView.isHidden = (imageType == .noImage)
        switch imageType {
        case .info:
            self.emptyImageView.image = UIImage.dealiIcon(named: "ic_notice_filled")?.resize(CGSize(width: 32.0, height: 32.0)).withTintColor(DealiColor.g60)
        case .refresh:
            self.emptyImageView.image = UIImage.dealiIcon(named: "ic_refresh_2_filled")?.resize(CGSize(width: 32.0, height: 32.0)).withTintColor(DealiColor.g60)
        default:
            break
        }
        
        var baselineOffset = 0.0
        
        if let title = title, title.trimming().isEmpty == false {
            self.titleLabel.isHidden = false
            let titleStyle = NSMutableParagraphStyle()
            titleStyle.alignment = .center
            titleStyle.lineHeightMultiple = 1.15
            let titleFont = UIFont.sh3sb16
            baselineOffset = ((titleFont.lineHeight * titleStyle.lineHeightMultiple) - titleFont.lineHeight) / 4
            if #available(iOS 16.4, *) {
                baselineOffset = ((titleFont.lineHeight * titleStyle.lineHeightMultiple) - titleFont.lineHeight) / 2
            }
            
            self.titleLabel.attributedText = NSMutableAttributedString(string: title, attributes: [.font: titleFont, .foregroundColor: DealiColor.g100, .paragraphStyle: titleStyle, .baselineOffset: baselineOffset])
        } else {
            self.titleLabel.isHidden = true
        }
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.alignment = .center
        messageStyle.lineHeightMultiple = 1.2
        let messageFont = UIFont.b2r14
        baselineOffset = ((messageFont.lineHeight * messageStyle.lineHeightMultiple) - messageFont.lineHeight) / 4
        if #available(iOS 16.4, *) {
            baselineOffset = ((messageFont.lineHeight * messageStyle.lineHeightMultiple) - messageFont.lineHeight) / 2
        }
        
        self.messageLabel.attributedText = NSMutableAttributedString(string: message, attributes: [.font: messageFont, .foregroundColor: DealiColor.g60, .paragraphStyle: messageStyle, .baselineOffset: baselineOffset])
        
        if let actionButtonTitle = actionButtonTitle, actionButtonTitle.trimming().isEmpty == false {
            self.actionButton.isHidden = false
        } else {
            self.actionButton.isHidden = true
        }
        
        self.actionHandler = actionHandler
    }
}
