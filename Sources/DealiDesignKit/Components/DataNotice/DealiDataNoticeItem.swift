//
//  DealiDataNoticeItem.swift
//  
//
//  Created by Lee Chang Ho on 8/22/24.
//

import UIKit

public class DealiDataNoticeItem: UIView {
    
    private let preset: DealiDataNoticePreset
    
    private let contentStackView = UIStackView()
    
    public var contentStringArray: [String] = [] {
        didSet {
            self.makeItemContent()
        }
    }
    
    public init(preset: DealiDataNoticePreset) {
        self.preset = preset
        
        super.init(frame: .zero)
    
        self.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeItemContent() {
        self.contentStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for (index, contentString) in self.contentStringArray.enumerated() {
            print("self preset = \(self.preset) index = \(index + 1)")
            let contentView = UIView()
            self.contentStackView.addArrangedSubview(contentView)
            contentView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            switch self.preset {
            case .bullet, .numbering:
                let bulletContainerView = UIView()
                contentView.addSubview(bulletContainerView)
                bulletContainerView.snp.makeConstraints {
                    $0.top.left.equalToSuperview()
                }
                
                switch self.preset {
                case .bullet:
                    let bulletImageView = UILabel()
                    bulletContainerView.addSubview(bulletImageView)
                    bulletImageView.then {
                        $0.layer.cornerRadius = 1.5
                        $0.layer.masksToBounds = true
                        $0.backgroundColor = DealiColor.g80
                    }.snp.makeConstraints {
                        $0.top.bottom.equalToSuperview().inset(8.5)
                        $0.left.equalToSuperview()
                        $0.right.equalToSuperview().offset(-8.0)
                        $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
                    }
                default:
                    print("\(index + 1).")
                    let numberingLabel = UILabel()
                    bulletContainerView.addSubview(numberingLabel)
                    numberingLabel.then {
                        $0.attributedText = NSMutableAttributedString(string: "\(index + 1).").font(self.preset.font).color(self.preset.textColor).lineHeightMultiple(1.16)
                    }.snp.makeConstraints {
                        $0.top.left.bottom.equalToSuperview()
                        $0.right.equalToSuperview().offset(-4.0)
                        $0.width.equalTo(CGFloat("\(index + 1).".size(withAttributes: [.font: self.preset.font]).width))
                    }
                }
                
                let contentLabel = UILabel()
                contentView.addSubview(contentLabel)
                contentLabel.then {
                    $0.attributedText = NSMutableAttributedString(string: contentString).font(self.preset.font).color(self.preset.textColor).lineHeightMultiple(1.16)
                    $0.numberOfLines = 0
                }.snp.makeConstraints {
                    $0.top.bottom.right.equalToSuperview()
                    $0.left.equalTo(bulletContainerView.snp.right)
                }
            default:
                let contentLabel = UILabel()
                contentView.addSubview(contentLabel)
                contentLabel.then {
                    $0.attributedText = NSMutableAttributedString(string: contentString).cdataString()
                    $0.numberOfLines = 0
                }.snp.makeConstraints {
                    $0.top.left.bottom.right.equalToSuperview()
                }
            }
        }
    }
}
