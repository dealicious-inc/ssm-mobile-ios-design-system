//
//  DealiTag.swift
//  
//
//  Created by 박경우 on 12/7/23.
//

import UIKit

public final class DealiTag: UIView {

    public enum ESize {
        case large
        case medium
        case small
        
        var height: CGFloat {
            switch self {
            case .large:
                return 28.0
            case .medium:
                return 26.0
            case .small:
                return 16.0
            }
        }
        
        var padding: CGFloat {
            switch self {
            case .large:
                return 8.0
            case .medium:
                return 8.0
            case .small:
                return 4.0
            }
        }
        
        var font: UIFont {
            switch self {
            case .large:
                return .b2sb14
            case .medium:
                return .b4sb12
            case .small:
                return .c1sb10
            }
        }
    }
    
    public enum EColor {
        /// 배경:핑크 | 텍스트:레드 | 볼더:X
        case red // background: primary03 / text: primary01
        /// 배경:화이트 | 텍스트:빨강 | 볼더:빨강
        case whiteRed // background: primary04 / text: primary01 / border: primary01
        /// 배경:블루 | 텍스트:블루 | 볼더:X
        case blue // background: secondary03 / text: secondary01
        /// 배경:화이트 | 텍스트:블루 | 볼더:블루
        case whiteBlue // background: primary04 / text: secondary01 / border: secondary01
        /// 배경:오렌지 | 텍스트:오렌지 | 볼더:X
        case orange // background: secondary06 / text: secondary04
        /// 배경:화이트 | 텍스트:오렌지 | 볼더:오렌지
        case whiteOrange // background: primary04 / text: secondary04 / border: secondary04
        /// 배경:그레이 | 텍스트:그레이 | 볼더:X
        case gray // background: g10 / text: g80
        /// 배경:화이트 | 텍스트:그레이 | 볼더:그레이
        case whiteGray // background: primary04 / text: g80 / border: g20
        
        struct DealiTagColor {
            var backgroundColor: UIColor
            var textColor: UIColor
            var borderColor: UIColor?
        }
        
        var set: DealiTagColor {
            switch self {
            case .red:
                return DealiTagColor(backgroundColor: DealiColor.primary03, textColor: DealiColor.primary01)
            case .whiteRed:
                return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.primary01, borderColor: DealiColor.primary01)
            case .blue:
                return DealiTagColor(backgroundColor: DealiColor.secondary03, textColor: DealiColor.secondary01)
            case .whiteBlue:
                return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.secondary01, borderColor: DealiColor.secondary01)
            case .orange:
                return DealiTagColor(backgroundColor: DealiColor.secondary06, textColor: DealiColor.secondary04)
            case .whiteOrange:
                return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.secondary04, borderColor: DealiColor.secondary04)
            case .gray:
                return DealiTagColor(backgroundColor: DealiColor.g10, textColor: DealiColor.g80)
            case .whiteGray:
                return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.g80, borderColor: DealiColor.g20)
            }
        }
    }
    
    public var text: String = "" {
        didSet {
            self.titleLabel.text = text
        }
    }
    
    public var size: ESize = .large {
        didSet {
            self.titleLabel.then {
                $0.font = size.font
            }.snp.remakeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.height.equalTo(size.height)
                $0.left.right.equalToSuperview().inset(size.padding)
            }
        }
    }
    
    public var color: EColor = .red {
        didSet {
            let set = color.set
            self.do {
                $0.backgroundColor = set.backgroundColor
                if let borderColor = set.borderColor {
                    $0.layer.borderColor = borderColor.cgColor
                    $0.layer.borderWidth = 1.0
                } else {
                    $0.layer.borderWidth = 0.0
                }
            }
            self.titleLabel.do {
                $0.textColor = set.textColor
            }
        }
    }
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.do {
            $0.layer.cornerRadius = 4.0
            $0.clipsToBounds = true
        }
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
