//
//  DealiTag.swift
//  
//
//  Created by 박경우 on 12/7/23.
//

import UIKit

extension DealiTag {
    static func tag(_ tag: String) -> DealiTag {
        return DealiTag().then {
            $0.name = EName(rawValue: tag.replacingOccurrences(of: "()", with: "")) ?? .tagFilledLarge01
        }
    }
    
    public static func tagFilledLarge01(functionName: String = #function) -> DealiTag {
        return tag(functionName)
    }
    
    public static func tagFilledLarge02(functionName: String = #function) -> DealiTag {
        return tag(functionName)
    }
    
    public static func tagFilledLarge03(functionName: String = #function) -> DealiTag {
        return tag(functionName)
    }
    
    public static func tagFilledLarge04(functionName: String = #function) -> DealiTag {
        return tag(functionName)
    }
}

public final class DealiTag: UIView {

    public enum EName: String {
        /// Background:Pink/Text:Pink
        case tagFilledLarge01
        /// Background:Blue/Text:Blue
        case tagFilledLarge02
        /// Background:Orange/Text:Orange
        case tagFilledLarge03
        /// Background:Gray/Text:Gray
        case tagFilledLarge04
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineLarge01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineLarge02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineLarge03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineLarge04
        /// Background:Pink/Text:Pink
        case tagFilledMedium01
        /// Background:Blue/Text:Blue
        case tagFilledMedium02
        /// Background:Orange/Text:Orange
        case tagFilledMedium03
        /// Background:Gray/Text:Gray
        case tagFilledMedium04
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineMedium01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineMedium02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineMedium03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineMedium04
        /// Background:Pink/Text:Pink
        case tagFilledSmall01
        /// Background:Blue/Text:Blue
        case tagFilledSmall02
        /// Background:Orange/Text:Orange
        case tagFilledSmall03
        /// Background:Gray/Text:Gray
        case tagFilledSmall04
        /// Background:White/Text:Pink/Border:Pink
        case tagOutlineSmall01
        /// Background:White/Text:Blue/Border:Blue
        case tagOutlineSmall02
        /// Background:White/Text:Orange/Border:Orange
        case tagOutlineSmall03
        /// Background:White/Text:Gray/Border:Gray
        case tagOutlineSmall04
        
        var font: UIFont {
            let name = self.rawValue
            if name.contains("Large") == true {
                return .b2sb14
            } else if name.contains("Medium") == true {
                return .b4sb12
            } else { // Small
                return .c1sb10
            }
        }
        
        struct DealiTagSize {
            var height: CGFloat
            var padding: CGFloat
        }
        
        var size: DealiTagSize {
            let name = self.rawValue
            if name.contains("Large") == true {
                return DealiTagSize(height: 28.0, padding: 8.0)
            } else if name.contains("Medium") == true {
                return DealiTagSize(height: 26.0, padding: 8.0)
            } else { // Small
                return DealiTagSize(height: 16.0, padding: 4.0)
            }
        }
        
        struct DealiTagColor {
            var backgroundColor: UIColor
            var textColor: UIColor
            var borderColor: UIColor?
        }
        
        var color: DealiTagColor {
            let name = self.rawValue
            let number = Int(name.suffix(2))
            
            if name.contains("Filled") == true {
                switch number {
                case 1:
                    return DealiTagColor(backgroundColor: DealiColor.primary03, textColor: DealiColor.primary01)
                case 2:
                    return DealiTagColor(backgroundColor: DealiColor.secondary03, textColor: DealiColor.secondary01)
                case 3:
                    return DealiTagColor(backgroundColor: DealiColor.secondary06, textColor: DealiColor.secondary04)
                default: // 4
                    return DealiTagColor(backgroundColor: DealiColor.g10, textColor: DealiColor.g80)
                }
            } else {
                switch number {
                case 1:
                    return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.primary01, borderColor: DealiColor.primary01)
                case 2:
                    return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.secondary01, borderColor: DealiColor.secondary01)
                case 3:
                    return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.secondary04, borderColor: DealiColor.secondary04)
                default: // 4
                    return DealiTagColor(backgroundColor: DealiColor.primary04, textColor: DealiColor.g80, borderColor: DealiColor.g20)
                }
            }
        }
        
    }

    
    public var text: String? {
        didSet {
            self.titleLabel.text = text
        }
    }
    
    public var name: EName = .tagFilledLarge01 {
        didSet {
            
            // 사이즈 & 폰트
            let size = name.size

            self.titleLabel.then {
                $0.font = name.font
            }.snp.remakeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.height.equalTo(size.height)
                $0.left.right.equalToSuperview().inset(size.padding)
            }
            
            // 색상
            let color = name.color
            
            self.do {
                $0.backgroundColor = color.backgroundColor
                if let borderColor = color.borderColor {
                    $0.layer.borderColor = borderColor.cgColor
                    $0.layer.borderWidth = 1.0
                } else {
                    $0.layer.borderWidth = 0.0
                }
            }
            self.titleLabel.do {
                $0.textColor = color.textColor
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
