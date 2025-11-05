//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 11/5/25.
//

import SwiftUI

public struct TypoTextView: View {
    let attributedString: AttributedString
    
    public init(attributedString: AttributedString) {
        self.attributedString = attributedString
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("as-is")
            Text(attributedString)
                .background(.pink)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .overlay(
                    GeometryReader { geo in
                        Text("\(Int(geo.size.height))pt")
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.5))
                    }
                )
            
            Text("to-be")
            Text(attributedString)
                .setLineSpacing(attributedString: attributedString)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .overlay(
                    GeometryReader { geo in
                        Text("\(Int(geo.size.height))pt")
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.5))
                    }
                )
        }
    }
}

struct TypoTextView_Previews: PreviewProvider {
    static var previews: some View {
        let text1 = "…‘Beauty is in the eye of the beholder.’ ".byCharWrapping
        let text2 = "사랑하는 사람은 뭐든지 다 예뻐 보인다는 말인데, 마케팅에서 성공한 디자인은 다 예뻐 보이는 법이지요. —폴 랜드(Paul Rand)".byCharWrapping
        let attStr1 = AttributedString(text1)
            .setFont(.h1sb32)
            .setColor(.g100)
        
        let attStr2 = AttributedString(text2)
            .setFont(.sh1sb20)
            .setColor(.white)
        
        let result = attStr1 + attStr2
        
        return TypoTextView(attributedString: result)
    }
}

public extension AttributedString {
    func getLineSpacing() -> CGFloat? {
        let uiFonts = self.runs.compactMap { $0.font?.uiFont }
        guard uiFonts.isEmpty == false else { return nil }
        let lineSpacing = uiFonts.map { $0.dealiLineHeight - $0.lineHeight }.max()
        return lineSpacing
    }
    
    func setFont(_ font: Font) -> AttributedString {
        var copy = self
        copy.font = font
        return copy
    }
    
    func setColor(_ color: Color) -> AttributedString {
        var copy = self
        copy.foregroundColor = color
        return copy
    }
    
}

extension Text {
    func setLineSpacing(attributedString: AttributedString) -> some View {
        let lineSpacing = attributedString.getLineSpacing() ?? 0
        return self
            .background(.pink)
            .padding(.vertical, lineSpacing / 2)
            .background(.blue)
            .lineSpacing(lineSpacing)
    }
}

public extension String {
    var byCharWrapping: Self {
        map(String.init).joined(separator: "\u{200B}")
    }
}
