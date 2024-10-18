//
//  DealiColor.swift
//  
//
//  Created by JohyeonYoon on 2023/07/11.
//

import UIKit
import SwiftUI

public extension Color {
    var primary01: Color {
        PrimaryColor.primary01.color
    }
}

public enum DealiColor {
    
    
    // 사용의 편의를 위함
    public static let primary01: UIColor = PrimaryColor.primary01.uiColor
    public static let primary02: UIColor = PrimaryColor.primary02.uiColor
    public static let primary03: UIColor = PrimaryColor.primary03.uiColor
    public static let primary04: UIColor = PrimaryColor.primary04.uiColor
    public static let primary05: UIColor = PrimaryColor.primary05.uiColor
    
    public static let primaryGradient: [UIColor] = Gradient.primaryGradient.colors
    
    public static let secondary01: UIColor = SecondaryColor.secondary01.uiColor
    public static let secondary02: UIColor = SecondaryColor.secondary02.uiColor
    public static let secondary03: UIColor = SecondaryColor.secondary03.uiColor
    public static let secondary04: UIColor = SecondaryColor.secondary04.uiColor
    public static let secondary05: UIColor = SecondaryColor.secondary05.uiColor
    public static let secondary06: UIColor = SecondaryColor.secondary06.uiColor
    
    
    // MARK: Gray
    public static let g05: UIColor = GrayColor.g05.uiColor
    public static let g10: UIColor = GrayColor.g10.uiColor
    public static let g20: UIColor = GrayColor.g20.uiColor
    public static let g30: UIColor = GrayColor.g30.uiColor
    public static let g40: UIColor = GrayColor.g40.uiColor
    public static let g50: UIColor = GrayColor.g50.uiColor
    public static let g60: UIColor = GrayColor.g60.uiColor
    public static let g70: UIColor = GrayColor.g70.uiColor
    public static let g80: UIColor = GrayColor.g80.uiColor
    public static let g100: UIColor = GrayColor.g100.uiColor

    public static let error: UIColor = ServiceColor.error.uiColor
    public static let warning: UIColor = ServiceColor.warning.uiColor
    public static let linkAndInfo: UIColor = ServiceColor.linkAndInfo.uiColor
    public static let success: UIColor = ServiceColor.success.uiColor
    
    // MARK: Etc
    public static let b70: UIColor = EtcColor.b70.uiColor
    public static let b50: UIColor = EtcColor.b50.uiColor
    public static let b40: UIColor = EtcColor.b40.uiColor
    public static let b30: UIColor = EtcColor.b30.uiColor
    public static let b20: UIColor = EtcColor.b20.uiColor
    public static let b10: UIColor = EtcColor.b10.uiColor
    public static let b5: UIColor = EtcColor.b5.uiColor
    public static let w90: UIColor = EtcColor.w90.uiColor
    public static let w70: UIColor = EtcColor.w70.uiColor
    public static let w50: UIColor = EtcColor.w50.uiColor
    public static let w30: UIColor = EtcColor.w30.uiColor
    public static let w20: UIColor = EtcColor.w20.uiColor
    public static let w15: UIColor = EtcColor.w15.uiColor
    public static let w10: UIColor = EtcColor.w10.uiColor
    public static let w5: UIColor = EtcColor.w5.uiColor
}

protocol ColorsConfigurable: RawRepresentable where RawValue == Int {
    var colors: [UIColor] { get }
    var gradient: [Int] { get }
}

extension ColorsConfigurable {
    var colors: [UIColor] {
        var colorArray: [UIColor] = []
        for hex in self.gradient {
            colorArray.append(UIColor(rgb: hex, alpha: 1.0))
        }
        return colorArray
    }
}


enum Gradient: Int, ColorsConfigurable {
    case primaryGradient
    
    var gradient: [Int] {
        switch self {
        case .primaryGradient:
            return [0xFB4760, 0xFE1EA4]
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ColorPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("etc 컬러")
            
            HStack {
                ZStack {
                    UIViewPreview {
                        let view = UIView()
                        view.backgroundColor = DealiColor.b70
                        return view
                    }
                    
                    Text("b70")
                    
                }
                
                ZStack {
                    UIViewPreview {
                        let view = UIView()
                        view.backgroundColor = DealiColor.b50
                        return view
                    }
                    
                    Text("b50")
                    
                }
                
            }
            
        }
            .padding(10.0)
            .previewLayout(.sizeThatFits)
        }
    }

#endif
