//
//  UIFont+Extension.swift
//  
//
//  Created by 윤조현 on 2023/04/26.
//

import UIKit

public extension UIFont {
    static let h1sb32: UIFont = DealiFont.h1SemiBold.systemFont
    
    static let h2sb24: UIFont = DealiFont.h2SemiBold.systemFont
    
    static let h3sb28: UIFont = DealiFont.h3SemiBold.systemFont
    
    static let sh1sb20: UIFont = DealiFont.sh1SemiBold.systemFont
    static let sh1r20: UIFont = DealiFont.sh1Regular.systemFont
    
    static let sh2sb18: UIFont = DealiFont.sh2SemiBold.systemFont
    static let sh2r18: UIFont = DealiFont.sh2Regular.systemFont
    
    static let sh3sb16: UIFont = DealiFont.sh3SemiBold.systemFont
    static let sh3r16: UIFont = DealiFont.sh3Regular.systemFont
    
    static let b1sb15: UIFont = DealiFont.b1SemiBold.systemFont
    static let b1r15: UIFont = DealiFont.b1Regular.systemFont
    
    static let b2sb14: UIFont = DealiFont.b2SemiBold.systemFont
    static let b2r14: UIFont = DealiFont.b2Regular.systemFont

    static let b3sb13: UIFont = DealiFont.b3SemiBold.systemFont
    static let b3r13: UIFont = DealiFont.b3Regular.systemFont
   
    static let b4sb12: UIFont = DealiFont.b4SemiBold.systemFont
    static let b4r12: UIFont = DealiFont.b4Regular.systemFont

    static let c1sb10: UIFont = DealiFont.c1SemiBold.systemFont
    static let c1r10: UIFont = DealiFont.c1Regular.systemFont
}

public extension UIFont {
    
    var dealiLineHeight: CGFloat {
        guard self.fontName.contains("Pretendard") else { return self.lineHeight }
        switch self.pointSize {
        case 32.0: return 40.0
        case 24.0: return 32.0
        case 28.0: return 36.0
        case 20.0: return 28.0
        case 18.0: return 26.0
        case 16.0: return 22.0
        case 15.0: return 20.0
        case 14.0: return 20.0
        case 13.0: return 18.0
        case 12.0: return 16.0
        case 10.0: return 14.0
        default: return self.lineHeight
        }
    }
    
    static func getPretendard(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        var font: UIFont? {
            if weight == .bold {
                return UIFont(name: "PretendardJP-Bold", size: size)
            } else if weight == .medium {
                return UIFont(name: "PretendardJP-Medium", size: size)
            } else if weight == .semibold {
                return UIFont(name: "PretendardJP-SemiBold", size: size)
            } else {
                return UIFont(name: "PretendardJP-Regular", size: size)
            }
            
        }

        return font ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FontPreview: PreviewProvider {
    
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Deali Font Style")
                .font(.system(size: 30.0, weight: .bold))
            
            Divider()
            
            Text("h1b32")
                .bold()
            UIViewPreview {
                let textView = UITextView()
                textView.text = "ABC 123 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 God blessed the East Sea and Mt."
                textView.font = .h1sb32
                
                return textView
            }
            
            Divider()
            
            Text("h2b24")
                .bold()
            UIViewPreview {
                let textView = UITextView()
                textView.text = "ABC 123 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 God blessed the East Sea and Mt."
                textView.font = .h2sb24
                
                return textView
            }
            
            Spacer()
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif
