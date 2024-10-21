//
//  ColorItemView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 10/18/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct ColorItemView: View {
    @State var colorData: ColorData
    
    var body: some View {
        
        Text(colorData.name)
            .font(.system(size:15, weight: .semibold))
            .foregroundStyle(colorData.isDarkShade ? .white : .black)
            .frame(width: 100.0, height: 100.0)
            .background(colorData.color)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

struct ColorData: Identifiable {
    let id = UUID()
    var name: String
    var color: Color
    var isDarkShade: Bool = true
}

#Preview {
    ColorItemView(colorData: ColorData( name: "primary01", color: .primary01, isDarkShade: true))
}

