//
//  DealiDescriptionItem.swift
//
//
//  Created by Lee Chang Ho on 8/22/24.
//

import UIKit

public class DealiDescriptionItem: UIView {
    
    private var style: DealiDescriptionStyle?
    
    private let titleLabel = UILabel()
    private let descriptionStackView = UIStackView()
    
    private var title: String? {
        didSet {
            if let title = self.title {
                self.titleLabel.isHidden = false
                self.titleLabel.attributedText = NSMutableAttributedString(string: title)
                    .font(.b3sb13)
                    .color(DealiColor.g100)
                    .alignment(.left)
                    .setLineHeight()
            } else {
                self.titleLabel.isHidden = true
            }
        }
    }
    private var descriptionStringArray: [String] = [] {
        didSet {
            self.makeItemContent()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        let contentStackView = UIStackView()
        self.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    
        contentStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.then {
            $0.isHidden = true
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(self.descriptionStackView)
        self.descriptionStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(model: DealiDescriptionItemModel?) {
        guard let model = model else { return }
        
        self.style = model.style
        self.title = model.title
        self.descriptionStringArray = model.descriptionStringArray
    }
    
    private func makeItemContent() {
        guard let style = self.style else { return }
        self.descriptionStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for (index, descriptionString) in self.descriptionStringArray.enumerated() {
            let descriptionContainerView = UIView()
            self.descriptionStackView.addArrangedSubview(descriptionContainerView)
            descriptionContainerView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            switch style {
            case .bullet, .numbering:
                let bulletContainerView = UIView()
                descriptionContainerView.addSubview(bulletContainerView)
                bulletContainerView.snp.makeConstraints {
                    $0.top.left.equalToSuperview()
                }
                
                switch style {
                case .bullet:
                    let bulletImageView = UILabel()
                    bulletContainerView.addSubview(bulletImageView)
                    bulletImageView.then {
                        $0.layer.cornerRadius = 1.5
                        $0.layer.masksToBounds = true
                        $0.backgroundColor = DealiColor.g80
                    }.snp.makeConstraints {
                        $0.top.bottom.equalToSuperview().inset(7.5)
                        $0.left.equalToSuperview()
                        $0.right.equalToSuperview().offset(-8.0)
                        $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
                    }
                default:
                    let numberingLabel = UILabel()
                    bulletContainerView.addSubview(numberingLabel)
                    numberingLabel.then {
                        $0.attributedText = NSMutableAttributedString(string: "\(index + 1).")
                            .font(style.font)
                            .color(style.textColor)
                            .setLineHeight()
                    }.snp.makeConstraints {
                        $0.top.left.bottom.equalToSuperview()
                        $0.right.equalToSuperview().offset(-4.0)
                        $0.width.equalTo(CGFloat("\(index + 1).".size(withAttributes: [.font: style.font]).width))
                    }
                }
                
                let descriptionLabel = UILabel()
                descriptionContainerView.addSubview(descriptionLabel)
                descriptionLabel.then {
                    $0.attributedText = NSMutableAttributedString(string: descriptionString)
                        .font(style.font)
                        .color(style.textColor)
                        .setLineHeight()
                    $0.numberOfLines = 0
                }.snp.makeConstraints {
                    $0.top.bottom.right.equalToSuperview()
                    $0.left.equalTo(bulletContainerView.snp.right)
                }
            default:
                let descriptionLabel = UILabel()
                descriptionContainerView.addSubview(descriptionLabel)
                descriptionLabel.then {
                    $0.attributedText = NSMutableAttributedString(string: descriptionString).cdataString()
                    $0.numberOfLines = 0
                }.snp.makeConstraints {
                    $0.top.left.bottom.right.equalToSuperview()
                }
            }
        }
    }
}
