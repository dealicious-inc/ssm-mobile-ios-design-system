//
//  FullSwiftUIBaseView.swift
//  DealiDesignSystemSampleApp
//
//  Created by 조서현 on 2/14/25.
//  Copyright © 2025 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift

import DealiDesignKit

struct FullSwiftUIBaseView: View {
    let components: [Component] = [Component(title: "Alert", linkView: AlertTestView()),
                                   Component(title: "Button", linkView: ButtonTestView())]
    
    
    var body: some View {
        if #available(iOS 16.0, *) {
            let sortedComponents = self.components.sorted { (component1, component2) -> Bool in
                return component1.title < component2.title
            }
            
            List(sortedComponents) { component in
                NavigationLink(component.title) {
                    component.linkView
                }
            }
            .navigationBarTitle("Full SwiftUI Base", displayMode: .inline)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    FullSwiftUIBaseView()
}

struct ComponentView: View {
    let component: Component
    
    var body: some View {
        Text(component.title)
    }
}

struct Component: Identifiable {
    let id = UUID()
    let title: String
    let linkView: AnyView
    
    init<V: View>(title: String, linkView: V) {
        self.title = title
        self.linkView = AnyView(linkView)
    }
}
