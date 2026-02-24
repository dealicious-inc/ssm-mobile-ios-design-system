//
//  String+Extension.swift
//  DealiDesignKit
//
//  Created by 조서현 on 11/6/25.
//

import Foundation
import SwiftUI

public extension String {
    /// 각 문자 사이에 zero-width space 문자를 삽입하여 Character 단위 줄바꿈 구현
    var byCharWrapping: Self {
        map(String.init).joined(separator: "\u{200B}")
    }
}
