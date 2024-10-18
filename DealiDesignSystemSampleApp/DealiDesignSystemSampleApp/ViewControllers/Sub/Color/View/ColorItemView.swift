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
    @State var colorInfo: ColorInfo
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ColorInfo {
    var name: String
    var color: Color
}

#Preview {
    ColorItemView(colorInfo: ColorInfo(name: "primary01", color: .red))
}


extension UIColor {
    func changeToColor() -> Color {
        .init(self)
    }
}
