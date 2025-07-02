//
//  UIColor+SystemColor.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 10/21/24.
//

import UIKit

// MARK: - Primary
public extension UIColor {
    static var primary01: UIColor { PrimaryColor.primary01.color() }
    static var primary02: UIColor { PrimaryColor.primary02.color() }
    static var primary03: UIColor { PrimaryColor.primary03.color() }
    static var primary04: UIColor { PrimaryColor.primary04.color() }
    static var primary05: UIColor { PrimaryColor.primary05.color() }
    static var primary06: UIColor { PrimaryColor.primary06.color() }
    static var primary07: UIColor { PrimaryColor.primary07.color() }
    
    static var primaryGradient: [UIColor] { PrimaryGradient.gradient.colors }
}

// MARK: - Secondary
public extension UIColor {
    static var secondary01: UIColor { SecondaryColor.secondary01.color() }
    static var secondary02: UIColor { SecondaryColor.secondary02.color() }
    static var secondary03: UIColor { SecondaryColor.secondary03.color() }
    static var secondary04: UIColor { SecondaryColor.secondary04.color() }
    static var secondary05: UIColor { SecondaryColor.secondary05.color() }
    static var secondary06: UIColor { SecondaryColor.secondary06.color() }
}

// MARK: - Gray
public extension UIColor {
    static var g05: UIColor { GrayColor.g05.color() }
    static var g10: UIColor { GrayColor.g10.color() }
    static var g20: UIColor { GrayColor.g20.color() }
    static var g30: UIColor { GrayColor.g30.color() }
    static var g40: UIColor { GrayColor.g40.color() }
    static var g50: UIColor { GrayColor.g50.color() }
    static var g60: UIColor { GrayColor.g60.color() }
    static var g70: UIColor { GrayColor.g70.color() }
    static var g80: UIColor { GrayColor.g80.color() }
    static var g100: UIColor { GrayColor.g100.color() }
}

// MARK: - Service
public extension UIColor {
    static var error: UIColor { ServiceColor.error.color() }
    static var warning: UIColor { ServiceColor.warning.color() }
    static var linkAndInfo: UIColor { ServiceColor.linkAndInfo.color() }
    static var success: UIColor { ServiceColor.success.color() }
}

// MARK: - ETC
public extension UIColor {
    static var b70: UIColor { EtcColor.b70.color() }
    static var b50: UIColor { EtcColor.b50.color() }
    static var b40: UIColor { EtcColor.b40.color() }
    static var b30: UIColor { EtcColor.b30.color() }
    static var b20: UIColor { EtcColor.b20.color() }
    static var b10: UIColor { EtcColor.b10.color() }
    static var b5: UIColor { EtcColor.b5.color() }
    static var b2: UIColor { EtcColor.b2.color() }
    static var w90: UIColor { EtcColor.w90.color() }
    static var w70: UIColor { EtcColor.w70.color() }
    static var w50: UIColor { EtcColor.w50.color() }
    static var w30: UIColor { EtcColor.w30.color() }
    static var w20: UIColor { EtcColor.w20.color() }
    static var w15: UIColor { EtcColor.w15.color() }
    static var w10: UIColor { EtcColor.w10.color() }
    static var w5: UIColor { EtcColor.w5.color() }
}

// MARK: - 소매 멤버십
public extension UIColor {
    static var mbs01: UIColor { MBSColor.mbs01.color() }
    static var mbs02: UIColor { MBSColor.mbs02.color() }
    @available(*, deprecated, message: "Use MbsGradient.gradient01.colors instead")
    static var mbsGradient: [UIColor] { MbsGradient.gradient01.colors }
}
