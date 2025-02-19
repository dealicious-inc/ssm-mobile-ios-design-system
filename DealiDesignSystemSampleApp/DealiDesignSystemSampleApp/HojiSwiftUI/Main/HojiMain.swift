//
//  HojiMain.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 2/19/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI

struct HojiMain: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, content: {
                Text("Hello, World!")
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        Text("Hello, World!")
                        Text("Hello, World!")
                        Text("Hello, World!")
                        Text("Hello, World!")
                    }
                }
            })
        }
    }
}

#Preview {
    HojiMain()
}
