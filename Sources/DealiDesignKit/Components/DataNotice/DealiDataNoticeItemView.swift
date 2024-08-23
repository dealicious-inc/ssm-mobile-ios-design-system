//
//  DealiDataNoticeItemView.swift
//  
//
//  Created by Lee Chang Ho on 8/22/24.
//

import UIKit

public class DealiDataNoticeItemView: UIView {
    
    private let preset: DealiDataNoticePreset
    
    private let contentStackView = UIStackView()
    
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
    
    public func configure(uiModel: DealiDataNoticeItemViewUIModel?) {
        guard let uiModel else { return }
        
        self.contentStackView.subviews.forEach { $0.removeFromSuperview() }
        
        switch self.preset {
        case .titleAndBullet(_), .titleAndNumbering(_):
            let titleLabel = UILabel()
            self.contentStackView.addArrangedSubview(titleLabel)
            titleLabel.then {
                $0.numberOfLines = 0
                $0.attributedText = NSMutableAttributedString(string: uiModel.titleString).font(self.preset.titleFont).color(self.preset.titleTextColor).lineHeightMultiple(1.16)
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        default:
            break
        }
        
        for (index, contentString) in uiModel.contentStringArray.enumerated() {
            let contentView = UIView()
            self.contentStackView.addArrangedSubview(contentView)
            contentView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            
        }
    }
    
//    public func configure(uiModel: DealiDataNoticeItemViewUIModel?) {
//        guard let uiModel else { return }
//        
//        self.contentStackView.subviews.forEach { $0.removeFromSuperview() }
//        
//        if uiModel.titleType != .none {
//            let titleLabel = UILabel()
//            self.contentStackView.addArrangedSubview(titleLabel)
//            titleLabel.then {
//                $0.numberOfLines = 0
//                $0.attributedText = NSMutableAttributedString(string: uiModel.titleString).font(uiModel.titleFont).color(uiModel.titleTextColor).lineHeightMultiple(1.16)
//            }.snp.makeConstraints {
//                $0.left.right.equalToSuperview()
//            }
//        }
//        
//        for (index, contentString) in uiModel.contentStringArray.enumerated() {
//            let contentView = UIView()
//            self.contentStackView.addArrangedSubview(contentView)
//            contentView.snp.makeConstraints {
//                $0.left.right.equalToSuperview()
//            }
//            
//            let contentLabel = UILabel()
//            
//            switch uiModel.contentType {
//            case .html:
//                contentView.addSubview(contentLabel)
//                contentLabel.then {
//                    $0.numberOfLines = 0
//                    $0.attributedText = NSMutableAttributedString(string: contentString).cdataString()
//                }.snp.makeConstraints {
//                    $0.top.left.bottom.right.equalToSuperview()
//                }
//            case .number, .bullet:
//                let bulletContentView = UIView()
//                contentView.addSubview(bulletContentView)
//                bulletContentView.snp.makeConstraints {
//                    $0.top.left.equalToSuperview()
//                }
//                
//                contentView.addSubview(contentLabel)
//                contentLabel.then {
//                    $0.numberOfLines = 0
//                    $0.attributedText = NSMutableAttributedString(string: contentString).font(.b3r13).color(DealiColor.g80).lineHeightMultiple(1.16)
//                }.snp.makeConstraints {
//                    $0.top.bottom.right.equalToSuperview()
//                    $0.left.equalTo(bulletContentView.snp.right)
//                }
//                
//                if uiModel.contentType == .number {
//                    let numberLabel = UILabel()
//                    bulletContentView.addSubview(numberLabel)
//                    numberLabel.then {
//                        $0.attributedText = NSMutableAttributedString(string: "\(index + 1).").font(.b3r13).color(DealiColor.g80).lineHeightMultiple(1.16)
//                    }.snp.makeConstraints {
//                        $0.top.left.bottom.equalToSuperview()
//                        $0.right.equalToSuperview().offset(-4.0)
//                    }
//                } else {
//                    let bulletImageView = UIImageView()
//                    bulletContentView.addSubview(bulletImageView)
//                    bulletImageView.then {
//                        $0.backgroundColor = DealiColor.g80
//                        $0.layer.masksToBounds = true
//                        $0.layer.cornerRadius = 1.5
//                    }.snp.makeConstraints {
//                        $0.left.bottom.equalToSuperview()
//                        $0.top.equalToSuperview().offset(7.5)
//                        $0.right.equalToSuperview().offset(-8.0)
//                        $0.size.equalTo(CGSize(width: 3.0, height: 3.0))
//                    }
//                }
//            default:
//                contentView.addSubview(contentLabel)
//                contentLabel.then {
//                    $0.numberOfLines = 0
//                    $0.attributedText = NSMutableAttributedString(string: contentString).font(.b3r13).color(DealiColor.g80).lineHeightMultiple(1.16)
//                }.snp.makeConstraints {
//                    $0.top.left.bottom.right.equalToSuperview()
//                }
//            }
//        }
//    }
    
}



public struct DealiDataNoticeItemViewUIModel {
    var titleString: String = ""
    var contentStringArray: [String] = []
}
