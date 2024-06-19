//
//  Int+Extension.swift
//
//
//  Created by JohyeonYoon on 4/29/24.
//

import Foundation

extension Int {
    func commaString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "ko_KR")
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

//extension Double {
//    func commaString() -> String {
//        
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        numberFormatter.locale = Locale(identifier: "ko_KR")
//        
//        let doubleString = String(self)
//        
//        let numberArray = doubleString.components(separatedBy: ".")
//        var numberString = numberArray[0]
//        if numberString.isEmpty {
//            numberString = "0"
//        }
//        
//        return (numberFormatter.string(from: NSNumber(value: Double(numberString) ?? 0.0)) ?? "") + ".\(numberArray[1])"
//    }
//}
