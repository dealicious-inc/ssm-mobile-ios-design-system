//
//  SwiftUIView.swift
//  DealiDesignKit
//
//  Created by 이창호 on 4/29/25.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    var tabItem: TabModel
    
    @Binding var currentTab: String
    
    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
            }
        }
        .onPreferenceChange(OffsetKey.self) { proxy in
            let offset = proxy.minY
            
            withAnimation(.linear(duration: 0.25)) {
                currentTab = (offset < 20.0 && -offset < (proxy.midX / 2) && currentTab != tabItem.id) ? "\(tabItem.id) SCROLL" : currentTab
            }
        }
    }
}


struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
