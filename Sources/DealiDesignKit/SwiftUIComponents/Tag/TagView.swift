//
//  TagView.swift
//  DealiDesignKit
//
//  Created by 조서현 on 5/30/25.
//

import SwiftUI

public struct TagView: View {
    private let text: String
    private let type: DealiTag.EType
    
    public init(text: String, type: DealiTag.EType) {
        self.text = text
        self.type = type
    }
    
    public var body: some View {
        Text(text)
            .font(Font(type.font))
            .frame(height: type.size.height)
            .padding(.horizontal, type.size.padding)
            .foregroundColor(Color(type.color.textColor))
            .background(Color(type.color.backgroundColor))
            .cornerRadius(4.0)
            .overlay(
                RoundedRectangle(cornerRadius: 4.0)
                    .stroke(
                        Color(type.color.borderColor ?? .clear),
                        lineWidth: 1.0
                    )
            )
    }
}

#Preview {
    VStack {
        TagView(text: "Test", type: .tagOutlineLarge01)
        TagView(text: "Test", type: .tagOutlineLarge04)

    }
}
