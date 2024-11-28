//
//  UIColor+SystemColor.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 10/21/24.
//

import UIKit

// MARK: - Primary
public extension UIColor {
    static var primary01: UIColor { PrimaryColor.primary01.uiColor() }
    static var primary02: UIColor { PrimaryColor.primary02.uiColor() }
    static var primary03: UIColor { PrimaryColor.primary03.uiColor() }
    static var primary04: UIColor { PrimaryColor.primary04.uiColor() }
    static var primary05: UIColor { PrimaryColor.primary05.uiColor() }
    
    static var primaryGradient: [UIColor] { Gradient.primaryGradient.colors }
}

// MARK: - Secondary
public extension UIColor {
    static var secondary01: UIColor { SecondaryColor.secondary01.uiColor() }
    static var secondary02: UIColor { SecondaryColor.secondary02.uiColor() }
    static var secondary03: UIColor { SecondaryColor.secondary03.uiColor() }
    static var secondary04: UIColor { SecondaryColor.secondary04.uiColor() }
    static var secondary05: UIColor { SecondaryColor.secondary05.uiColor() }
    static var secondary06: UIColor { SecondaryColor.secondary06.uiColor() }
}

// MARK: - Gray
public extension UIColor {
    static var g05: UIColor { GrayColor.g05.uiColor() }
    static var g10: UIColor { GrayColor.g10.uiColor() }
    static var g20: UIColor { GrayColor.g20.uiColor() }
    static var g30: UIColor { GrayColor.g30.uiColor() }
    static var g40: UIColor { GrayColor.g40.uiColor() }
    static var g50: UIColor { GrayColor.g50.uiColor() }
    static var g60: UIColor { GrayColor.g60.uiColor() }
    static var g70: UIColor { GrayColor.g70.uiColor() }
    static var g80: UIColor { GrayColor.g80.uiColor() }
    static var g100: UIColor { GrayColor.g100.uiColor() }
}

// MARK: - Service
public extension UIColor {
    static var error: UIColor { ServiceColor.error.uiColor() }
    static var warning: UIColor { ServiceColor.warning.uiColor() }
    static var linkAndInfo: UIColor { ServiceColor.linkAndInfo.uiColor() }
    static var success: UIColor { ServiceColor.success.uiColor() }
}

// MARK: - ETC
public extension UIColor {
    static var b70: UIColor { EtcColor.b70.uiColor() }
    static var b50: UIColor { EtcColor.b50.uiColor() }
    static var b40: UIColor { EtcColor.b40.uiColor() }
    static var b30: UIColor { EtcColor.b30.uiColor() }
    static var b20: UIColor { EtcColor.b20.uiColor() }
    static var b10: UIColor { EtcColor.b10.uiColor() }
    static var b5: UIColor { EtcColor.b5.uiColor() }
    static var w90: UIColor { EtcColor.w90.uiColor() }
    static var w70: UIColor { EtcColor.w70.uiColor() }
    static var w50: UIColor { EtcColor.w50.uiColor() }
    static var w30: UIColor { EtcColor.w30.uiColor() }
    static var w20: UIColor { EtcColor.w20.uiColor() }
    static var w15: UIColor { EtcColor.w15.uiColor() }
    static var w10: UIColor { EtcColor.w10.uiColor() }
    static var w5: UIColor { EtcColor.w5.uiColor() }
}
