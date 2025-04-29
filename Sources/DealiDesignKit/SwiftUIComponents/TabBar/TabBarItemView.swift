//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 4/29/25.
//

import SwiftUI

struct TabBarItemView: View {
    
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var preset: TabBarPreset = .tabBarSegment01
        @Published var model: LabeledTextModel?
    }
    
    public init() { }
    
    var body: some View {
        
    }
}

#Preview {
    TabBarItemView()
}
