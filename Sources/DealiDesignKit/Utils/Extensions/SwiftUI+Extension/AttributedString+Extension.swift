//
//  AttributedString+Extension.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/13/25.
//

import Foundation
import SwiftUI

public extension AttributedString {
    /// 특정 단어에 대해 스타일(폰트, 색상) 변경
    func highlighted(_ styles: [TextStyleAttributes]?) -> AttributedString {
        guard let styles = styles else { return self }
        var newString = self
        for style in styles {
            if let range = newString.range(of: style.text) {
                newString[range].foregroundColor = style.color
                newString[range].font = style.font
            }
        }
        return newString
    }
    
    /// 폰트 설정 (명칭 우선순위 때문에 setFont)
    func setFont(_ font: Font?) -> AttributedString {
        var newString = self
        if let font = font {
            newString.font = font
        }
        return newString
    }
    
    /// 컬러 설정
    func setColor(_ color: Color?) -> AttributedString {
        var newString = self
        if let color = color {
            newString.foregroundColor = color
        }
        return newString
    }
}

extension AttributedString {
    /// Text의 setLineHeight에 사용하기 위한 목적
    func getLineSpacing() -> CGFloat {
        let uiFonts = self.runs.compactMap { $0.font?.uiFont }
        guard uiFonts.isEmpty == false else { return 0 }
        let lineSpacing = uiFonts.map { $0.dealiLineHeight - $0.lineHeight }.max()
        return lineSpacing ?? 0
    }
}

public extension Text {
    /// 텍스트의 lineHeight 설정
    /// - lineSpacing / 2 만큼 상하 padding 추가, 줄 사이 lineSpacing 설정
    func setLineHeight(attributedString: AttributedString) -> some View {
        let lineSpacing = attributedString.getLineSpacing()
        return self
//            .background(.pink) // 적용 전 높이
            .padding(.vertical, lineSpacing / 2)
            .lineSpacing(lineSpacing)
//            .background(.blue) // 적용 후 높이
    }
}
