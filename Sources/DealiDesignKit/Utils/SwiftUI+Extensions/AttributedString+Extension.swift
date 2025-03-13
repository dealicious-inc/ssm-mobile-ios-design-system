//
//  File.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/13/25.
//

import Foundation
import SwiftUI

public extension AttributedString {
    /// 특정 단어에 대해 스타일(폰트, 색상) 변경
    func highlighted(_ styles: [TextStyleAttributes]) -> AttributedString {
        var newString = self
        for style in styles {
            if let range = newString.range(of: style.text) {
                newString[range].foregroundColor = style.color
                newString[range].font = style.font
            }
        }
        return newString
    }
}
