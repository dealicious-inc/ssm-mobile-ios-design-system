//
//  AttributedString+Extension.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/13/25.
//

import Foundation
import SwiftUI

public extension AttributedString {
    /// 여러 스타일을 순차적으로 적용
    func applyMultipleStyle(_ styles: [TextStyleAttributes]?) -> AttributedString {
        guard let styles = styles else { return self }
        var new = self
        for style in styles {
            new = new.applyStyle(style)
        }
        return new
    }
    
    /// 단일 스타일을 적용한 새로운 AttributedString 반환
    @discardableResult
    func applyStyle(_ style: TextStyleAttributes) -> AttributedString {
        guard let range = self.range(of: style.text) else { return self }
        var new = self
        new.edit(in: range) { slice in
            if let color = style.color {
                slice.foregroundColor = color.asColor()
            }
            if let font = style.font {
                slice.font = font.swiftUIFont
            }
            if style.underline {
                slice.underlineStyle = .single
                slice.underlineColor = slice.foregroundColor
            }
            if style.strikeThrough {
                slice.strikethroughStyle = .single
                slice.strikethroughColor = slice.foregroundColor
            }
        }
        return new
    }
    
    /// 폰트 설정
    func setFont(_ font: Font?) -> AttributedString {
        var new = self
        guard new.characters.isEmpty == false else { return self }
        if let font = font {
            new.font = font
        }
        return new
    }
    
    /// 컬러 설정
    func setColor(_ color: Color?) -> AttributedString {
        var new = self
        guard new.characters.isEmpty == false else { return self }
        if let color = color {
            new.foregroundColor = color
        }
        return new
    }
    
    func setLink( link: String, linkStyle: TextStyleAttributes) -> AttributedString {
        var new = self
        new = new.applyStyle(linkStyle)
        
        guard let range = new.range(of: linkStyle.text) else { return self }
        new.edit(in: range) { slice in
            slice.link = URL(string: link)!
        }
        
        return new
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
    
    mutating func edit(in range: Range<AttributedString.Index>,
        _ body: (inout AttributedString) -> Void
    ) {
        var slice = AttributedString(self[range])
        body(&slice)
        self.replaceSubrange(range, with: slice)
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
