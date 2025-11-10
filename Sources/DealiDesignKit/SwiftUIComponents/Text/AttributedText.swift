//
//  AttributedText.swift
//  DealiDesignKit
//
//  Created by 조서현 on 11/5/25.
//

import SwiftUI

public struct AttributedText: View {
    let attributedString: AttributedString
    var alignment: TextAlignment = .leading
    
    public init(_ attributedString: AttributedString,
                alignment: TextAlignment = .leading) {
        self.attributedString = attributedString
        self.alignment = alignment
    }
    
    public var body: some View {
        Text(attributedString)
            .setLineHeight(attributedString: attributedString)
            .multilineTextAlignment(alignment)
            .frame(maxWidth: .infinity, alignment: .center)
        // 디버그모드 라인 높이 확인용 overlay
//            .overlay(
//                GeometryReader { geo in
//                #if DEBUG
//                    Text("lineHeight: \(Int(geo.size.height))pt")
//                        .font(.caption)
//                        .foregroundColor(.white)
//                        .background(Color.black.opacity(0.5))
//                #endif
//                }
//            )
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        let text1 = "…‘Beauty is in the eye of the beholder.’ ".byCharWrapping
        let text2 = "사랑하는 사람은 뭐든지 다 예뻐 보인다는 말인데, 마케팅에서 성공한 디자인은 다 예뻐 보이는 법이지요. —폴 랜드(Paul Rand)".byCharWrapping
        let attStr1 = AttributedString(text1)
            .setFont(.h1sb32)
            .setColor(.g100)
        
        let attStr2 = AttributedString(text2)
            .setFont(.sh1sb20)
            .setColor(.g80)
        
        let result = attStr1 + attStr2
        
        return VStack(alignment: .leading, spacing: 8) {
            Text("as-is")
            Text(result)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

            Text("to-be")
            AttributedText(result)
                .padding(.horizontal, 20)
        }
    }
}
