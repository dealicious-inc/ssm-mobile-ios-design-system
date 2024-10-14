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
