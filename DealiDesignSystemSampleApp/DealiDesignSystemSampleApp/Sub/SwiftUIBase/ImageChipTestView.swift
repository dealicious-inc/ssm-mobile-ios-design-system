//
//  ImageChipTestView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 5/27/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import SwiftUI
import DealiDesignKit

struct ImageChipTestView: View {
    let viewModel = DealiImageChipViewModel(urlString: "https://images.unsplash.com/photo-1731021347639-8aac941f5e29?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8UzRNS0xBc0JCNzR8fGVufDB8fHx8fA%3D%3D", text: "이미지칩")
    
    var body: some View {
        HStack {
            DealiImageChip(viewModel: viewModel) {
                HStack(spacing: 2.0) {
                    Image.dealiIcon(named: "ic_speechbubble_filled")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color(.primary01))
                        .frame(width: 16, height: 16)
                    
                    Text("5")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.primary01))
                }
            }
        }
    }
}

#Preview {
    ImageChipTestView()
}
