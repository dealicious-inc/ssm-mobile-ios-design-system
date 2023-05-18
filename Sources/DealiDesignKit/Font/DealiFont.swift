//
//  DealiFont.swift
//
//
//  Created by JohyeonYoon on 2023/04/17.
//

import UIKit

enum DealiFont: String, CaseIterable {
    case h1Bold
    case h2Bold
    case sh1Bold, sh1Medium
    case sh2Bold, sh2Regular
    case sh3Bold, sh3Regular
    case b1Bold, b1Regular
    case b2Bold, b2Medium, b2Regular
    case b3Bold, b3Medium, b3Regulr
    case b4Bold, b4Medium, b4Regular
    case c1Bold, c1Regular
    
    var style: DealiFontProperty.Style {
        switch self {
        case .h1Bold:
            return DealiFontProperty.h1
        case .h2Bold:
            return DealiFontProperty.h2
        case .sh1Bold, .sh1Medium:
            return DealiFontProperty.sh1
        case .sh2Bold, .sh2Regular:
            return DealiFontProperty.sh2
        case .sh3Bold, .sh3Regular:
            return DealiFontProperty.sh3
        case .b1Bold, .b1Regular:
            return DealiFontProperty.b1
        case .b2Bold, .b2Medium, .b2Regular:
            return DealiFontProperty.b2
        case .b3Bold, .b3Medium, .b3Regulr:
            return DealiFontProperty.b3
        case .b4Bold, .b4Medium, .b4Regular:
            return DealiFontProperty.b4
        case .c1Bold, .c1Regular:
            return DealiFontProperty.c1
        }
    }
    
    var font: UIFont {
        var weight: UIFont.Weight
        
        if self.rawValue.contains("Bold") {
            weight = .bold
        } else if self.rawValue.contains("Medium") {
            weight = .medium
        } else {
            weight = .regular
        }
        
        let fontDescriptor = DealiFontProperty.fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        let font = UIFont(descriptor: fontDescriptor, size: self.style.size)
        font.dealiLineHeight = self.style.lineHeight
        
        return font
    }
    
    var fontTitle: String {
        switch self {
        case .h1Bold:
            return "H1_32_B"
        case .h2Bold:
            return "H2_24_B"
        case .sh1Bold:
            return "SH1_20_B"
        case .sh1Medium:
            return "SH1_20_M"
        case .sh2Bold:
            return "SH2_18_B"
        case .sh2Regular:
            return "SH2_18_R"
        case .sh3Bold:
            return "SH3_16_B"
        case .sh3Regular:
            return "SH3_16_R"
        case .b1Bold:
            return "B1_15_B"
        case .b1Regular:
            return "B1_15_R"
        case .b2Bold:
            return "B2_14_B"
        case .b2Medium:
            return "B2_14_M"
        case .b2Regular:
            return "B2_14_R"
        case .b3Bold:
            return "B3_13_B"
        case .b3Medium:
            return "B3_13_M"
        case .b3Regulr:
            return "B3_13_R"
        case .b4Bold:
            return "B4_12_B"
        case .b4Medium:
            return "B4_12_M"
        case .b4Regular:
            return "B4_12_R"
        case .c1Bold:
            return "C1_10_B"
        case .c1Regular:
            return "C1_10_R"
        }
    }
}

struct DealiFontProperty {
    struct Style {
        let size: CGFloat
        let lineHeight: CGFloat
    }
    
    static let h1 = Style(size: 32.0, lineHeight: 40.0)
    static let h2 = Style(size: 28.0, lineHeight: 36.0)
    static let sh1 = Style(size: 20.0, lineHeight: 60.0)
    static let sh2 = Style(size: 18.0, lineHeight: 30.0)
    static let sh3 = Style(size: 16.0, lineHeight: 28.0)
    static let b1 = Style(size: 14.0, lineHeight: 28.0)
    static let b2 = Style(size: 12.0, lineHeight: 20.0)
    static let b3 = Style(size: 10.0, lineHeight: 18.0)
    static let b4 = Style(size: 12.0, lineHeight: 18.0)
    static let c1 = Style(size: 10.0, lineHeight: 14.0)
 
    static let fontDescriptor = UIFontDescriptor.dealiFontDescriptor
}

extension UIFontDescriptor {
    static let dealiFontDescriptor: UIFontDescriptor = {
        return UIFontDescriptor().addingAttributes([.family: "Pretendard JP"])
    }()
}

public func registerDealiSystemFonts() {
    // 폰트 정보 (OTF 확장자)
    let fonts = [
        "PretendardJP-Black.otf",
        "PretendardJP-Bold.otf",
        "PretendardJP-ExtraBold.otf",
        "PretendardJP-ExtraLight.otf",
        "PretendardJP-Light.otf",
        "PretendardJP-Medium.otf",
        "PretendardJP-Regular.otf",
        "PretendardJP-SemiBold.otf",
        "PretendardJP-Thin.otf"
    ]
    
    // 폰트 등록하기.
    for font in fonts {
        UIFont.registerFont(fontName: font)
    }
}

extension UIFont {
    static func registerFont(fontName: String) {
        guard let pathForResourceString = Bundle.module.path(forResource: fontName, ofType: nil) else {
            print("could not find font file")
            return
        }
        
        guard let fontDataProvider = CGDataProvider(data: NSData(contentsOfFile: pathForResourceString)!) else {
            print("Could not create font data provider for \(pathForResourceString).")
            return
        }
        guard let font = CGFont(fontDataProvider) else {
            print("could not create font")
            return
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print(error!.takeUnretainedValue())
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
        font.dealiLineHeight = self.dealiLineHeight
        return font
    }
}
