//
//  DealiFont.swift
//
//
//  Created by JohyeonYoon on 2023/04/17.
//

import UIKit

/// 디자인시스템 Font에 적용되는 스타일. 스타일 관리용으로 내부적으로만 사용. 실제 사용은 UIFont extension에 정의된 정적변수를 사용한다.
///
/// ```swift
/// // 예시
/// let label = UILabel()
/// label.font = .h1b32
/// ```
enum DealiFont: String, CaseIterable {
    case h1SemiBold
    case h2SemiBold
    case h3SemiBold
    case sh1SemiBold, sh1Regular
    case sh2SemiBold, sh2Regular
    case sh3SemiBold, sh3Regular
    case b1SemiBold, b1Regular
    case b2SemiBold, b2Regular
    case b3SemiBold, b3Regular
    case b4SemiBold, b4Regular
    case c1SemiBold, c1Regular
    
    var fontSize: CGFloat {
        switch self {
        case .h1SemiBold:
            return DealiFontProperty.h1
        case .h2SemiBold:
            return DealiFontProperty.h2
        case .h3SemiBold:
            return DealiFontProperty.h3
        case .sh1SemiBold, .sh1Regular:
            return DealiFontProperty.sh1
        case .sh2SemiBold, .sh2Regular:
            return DealiFontProperty.sh2
        case .sh3SemiBold, .sh3Regular:
            return DealiFontProperty.sh3
        case .b1SemiBold, .b1Regular:
            return DealiFontProperty.b1
        case .b2SemiBold, .b2Regular:
            return DealiFontProperty.b2
        case .b3SemiBold, .b3Regular:
            return DealiFontProperty.b3
        case .b4SemiBold, .b4Regular:
            return DealiFontProperty.b4
        case .c1SemiBold, .c1Regular:
            return DealiFontProperty.c1
        }
    }
    
    var systemFont: UIFont {
        var weight: UIFont.Weight {
            
            if self.rawValue.contains("SemiBold") {
                return .semibold
            } else if self.rawValue.contains("Medium") {
                return .medium
            } else if self.rawValue.contains("Bold") {
                return .bold
            } else {
                return .regular
            }
        }
        
        return .getPretendard(weight: weight, size: self.fontSize)
    }
    
    public var font: UIFont {
        var font: UIFont!
        
        if self.rawValue.contains("SemiBold") {
            font = .getPretendard(weight: .semibold, size: self.fontSize)
        } else if self.rawValue.contains("Medium") {
            font = .getPretendard(weight: .medium, size: self.fontSize)
        } else if self.rawValue.contains("Bold") {
            font = .getPretendard(weight: .bold, size: self.fontSize)
        } else {
            font = .getPretendard(weight: .regular, size: self.fontSize)
        }
        
        return font
    }
    
}

struct DealiFontProperty {
    
    static let h1 = 32.0
    static let h2 = 24.0
    static let h3 = 28.0
    static let sh1 = 20.0
    static let sh2 = 18.0
    static let sh3 = 16.0
    static let b1 = 15.0
    static let b2 = 14.0
    static let b3 = 13.0
    static let b4 = 12.0
    static let c1 = 10.0
 
    static let fontDescriptor = UIFontDescriptor.dealiFontDescriptor
}

extension UIFontDescriptor {
    public static let dealiFontDescriptor: UIFontDescriptor = {
        return UIFontDescriptor().addingAttributes([.family: "Pretendard JP"])
    }()
}

public func registerDealiSystemFonts() {
    // 폰트 정보 (OTF 확장자)
    let fonts = [
        "PretendardJP-Bold.otf",
        "PretendardJP-Medium.otf",
        "PretendardJP-Regular.otf",
        "PretendardJP-SemiBold.otf"
    ]
    
    // 폰트 등록하기.
    for font in fonts {
        UIFont.registerFont(fontName: font)
    }
}

extension UIFont {
    static func registerFont(fontName: String) {
        guard let pathForResourceString = Bundle.module.path(forResource: fontName, ofType: nil) else {
            debugPrint("could not find font file")
            return
        }
        
        guard let fontDataProvider = CGDataProvider(data: NSData(contentsOfFile: pathForResourceString)!) else {
            debugPrint("Could not create font data provider for \(pathForResourceString).")
            return
        }
        guard let font = CGFont(fontDataProvider) else {
            debugPrint("could not create font")
            return
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            debugPrint(error!.takeUnretainedValue())
        }
    }
}

fileprivate extension UIFont {
    var regular: UIFont { return withWeight(.regular) }
    var medium: UIFont { return withWeight(.medium) }
    var bold: UIFont { return withWeight(.bold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        let font = UIFont(descriptor: descriptor, size: pointSize)
        return font
    }
}
