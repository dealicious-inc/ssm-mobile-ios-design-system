//
//  File.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/13/25.
//

import Foundation
import SwiftUI

public extension View {
    func font(_ font: UIFont) -> some View {
        
        let lineHeight = font.dealiLineHeight
        let offset = ((lineHeight - font.lineHeight) / 2.0)
        
        return self
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
//            .background(Color(uiColor: .white))
            .padding(.vertical, offset)
//            .background(Color(uiColor: .red))
    }
}
